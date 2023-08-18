package com.i2c.timesloggingws.loggingthreads;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.*;

import com.i2c.common.timelogging.util.TimeLoggingConstants;
import com.i2c.common.utils.constants.CommonConstants;
import com.i2c.oltpj.cache.cacheengine.readycache.CacheDataReaderImpl;
import com.i2c.services.common.business.util.constants.CommonBusinessConstants;
import com.i2c.timesloggingws.utils.TransTimeLogWSConstants;
import org.apache.log4j.Logger;

import com.i2c.common.timelogging.TransExecutionTimesLogger;
import com.i2c.common.utils.util.CommonUtils;
import com.i2c.services.common.beans.TransTimeLoggingVO;
import com.i2c.timesloggingws.utils.ServerConfigurations;
import com.i2c.timesloggingws.utils.TransTimeLogWSUtils;
import com.i2c.timesloggingws.utils.WaitingSingletonClass;

/**
 * @author hsami01
 */
public class SummaryLoggingControllerThread implements Runnable {

	private final static String CLASS_NAME = SummaryLoggingControllerThread.class.getName();

	private final static Logger LGR = Logger.getLogger(CLASS_NAME);
	private Map<String, ThreadPoolExecutor> instanceThreadPoolMap= null;
	public SummaryLoggingControllerThread(Map<String, ThreadPoolExecutor> instanceThreadPoolMap ) {
		this.instanceThreadPoolMap=instanceThreadPoolMap;
	}

	@Override
	public void run() {
		while (true) {
			try {
				getPriorityInstancesList();
				TransExecutionTimesLogger.refreshParametersFromCache();
				processTransTimeQueries();

				LGR.info(LGR.isInfoEnabled()
						? "Going to wait for  [" + ServerConfigurations.LOG_TRANS_TIME2S_MS + "] millisec"
						: null);
				synchronized (WaitingSingletonClass.getinstance()) {
					WaitingSingletonClass.getinstance().wait(Long.parseLong(ServerConfigurations.LOG_TRANS_TIME2S_MS));
					LGR.info(LGR.isInfoEnabled() ? "Wait is over" : null);
				}
			} catch (NumberFormatException | InterruptedException e) {
				CommonUtils.logException(LGR, e, CLASS_NAME);
			}
		}
	}

	/**
	 * 
	 */
	private void processTransTimeQueries()  {


		Queue<TransTimeLoggingVO> batchSizeQueue = null;
		ConcurrentMap<String, Queue<TransTimeLoggingVO>> queueBatchMap = new ConcurrentHashMap<String, Queue<TransTimeLoggingVO>>();
		TransTimeLogWSUtils.consumeTransTimeMap(queueBatchMap);
		SummaryLoggerForEachInstance instance=null;
		ThreadPoolExecutor threadPoolExecutor=null;
		ThreadPoolExecutor sharedThreadPoolExecutor=null;
		ExecutorService executorService =null;


		if (!CommonUtils.isNullOrEmptyMap(queueBatchMap)) {
			LGR.debug(LGR.isDebugEnabled() ? "Logging Trans Times for each instance" : null);
			//===============================================================================================
			executorService = Executors.newFixedThreadPool(queueBatchMap.size());
			sharedThreadPoolExecutor = instanceThreadPoolMap.get(TransTimeLogWSConstants.SHARED_INSTANCES);
			//================   Executor Services ==========================================================

			List<SummaryLoggerForEachInstance> tasks = new ArrayList<>();
			// Iterate over the instances and submit each instance for execution
			for (String instanceId : queueBatchMap.keySet()) {
				threadPoolExecutor = instanceThreadPoolMap.getOrDefault(instanceId, sharedThreadPoolExecutor);

				batchSizeQueue = new LinkedBlockingQueue<TransTimeLoggingVO>();
				LGR.info(LGR.isInfoEnabled() ? "Adding Queue for instance:  " + instanceId : null);
				batchSizeQueue.addAll(queueBatchMap.get(instanceId));
				LGR.info(LGR.isInfoEnabled() ? "Queue Added size" + batchSizeQueue.size() : null);
				instance = new SummaryLoggerForEachInstance(instanceId,batchSizeQueue,threadPoolExecutor);
				executorService.submit(instance);

			}
			LGR.info(LGR.isInfoEnabled() ? "Going to shutdown pool  "  : null);
			executorService.shutdown();
			LGR.info(LGR.isInfoEnabled() ? "Shutdown done  "  : null);
		} else {
			LGR.info(LGR.isInfoEnabled() ? "Trans time map is empty" : null);
		}
	}


	public void getPriorityInstancesList()
	{
		String instanceId=null;
		Integer instanceThreadPoolSize=null;
		List<String> whereList = new ArrayList<String>();
		whereList.add(TimeLoggingConstants.COL_IS_ACTIVE + CommonConstants.KEY_CHAR + TimeLoggingConstants.OPTION_Y);

		LGR.debug(LGR.isDebugEnabled() ? CommonUtils.concatValues("Getting trans_time_instances table data from cache") : null);

		List<Map<String, String>> transTimeInstanceDataList = null;

		try {
			transTimeInstanceDataList = CacheDataReaderImpl.get(CommonConstants.CACHE_INSTANCE_GLOBAL,TransTimeLogWSConstants.TRANS_TIME_INSTANCES, null,
					whereList, CommonBusinessConstants.CACHE_FETCH_FROM_DB);
		}
		catch (SQLException e) {
			LGR.error("Unable to retrieve 'MI_SERVICES' data from cache due to:", e);
		}
		catch (Exception e) {
			LGR.error("Unable to retrieve 'MI_SERVICES' data from cache due to:", e);
		}
		//
		if (!CommonUtils.isNullOrEmptyList(transTimeInstanceDataList)) {
			for (Map<String, String> transTimeInstanceRecord : transTimeInstanceDataList) {
				instanceId = transTimeInstanceRecord.get("instance_id");
				instanceThreadPoolSize=Integer.parseInt(transTimeInstanceRecord.get("inst_thrd_pool_size"));

				if(!instanceThreadPoolMap.containsKey(instanceId)) {
					instanceThreadPoolMap.put(instanceId, new ThreadPoolExecutor(1,
							instanceThreadPoolSize, 5L, TimeUnit.SECONDS,
							new SynchronousQueue<>()));
				}
				else {
					// instance already exist check for thread pool size
					if(!(instanceThreadPoolSize.equals(instanceThreadPoolMap.get(instanceId).getMaximumPoolSize())))
					{
						instanceThreadPoolMap.replace(instanceId, new ThreadPoolExecutor(1,
								instanceThreadPoolSize, 5L, TimeUnit.SECONDS,
								new SynchronousQueue<>()));
					}
				}
			}
		}

	}
}
