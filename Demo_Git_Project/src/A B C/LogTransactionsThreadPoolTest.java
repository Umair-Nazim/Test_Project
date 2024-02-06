package com.i2c.ai.services.betamodelexecutor.threadpool;

import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.junit.jupiter.api.Assertions.assertEquals;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;

import com.i2c.ai.common.beans.AIFraudSrvcResponseVO;
import com.i2c.ai.common.beans.AssignedRangeInfo;
import com.i2c.ai.common.buildprofilingstats.utils.ModelPipelinesInitializer;
import com.i2c.ai.common.buildprofilingstats.utils.ProfilingServicesCacheInitalizer;
import com.i2c.ai.common.datafetch.DataFetchCommonService;
import com.i2c.ai.common.exceps.CacheException;
import com.i2c.ai.services.betamodelexecutor.bl.AbstractSubController;
import com.i2c.ai.services.betamodelexecutor.bl.BetaModelExecutorContainer;
import com.i2c.ai.services.betamodelexecutor.bl.SubControllerEvaluateTransactions;
import com.i2c.ai.services.betamodelexecutor.bl.SubControllerFetchTransactions;
import com.i2c.ai.services.betamodelexecutor.task.TransBatchLoggingTask;
import com.i2c.ai.services.betamodelexecutor.utils.BetaModelExecutorConstants;
import com.i2c.mcp.batch.common.beans.ConfigurationParameters;
import com.i2c.mcp.batch.common.beans.ExecutionContextInfo;
import com.i2c.mcp.batch.common.excep.StartupFailedException;
import com.i2c.mcp.batch.common.beans.ResponseInfo;
import com.i2c.mcp.batch.common.utils.ResponseCodes;
import com.i2c.mcp.batch.services.databasehandler.DatabaseHandler;
import com.i2c.mcp.batch.services.databasehandler.exceps.DatabasePoolInitializtionException;
import com.i2c.services.common.exceps.CommonBaseException;
import com.i2c.services.common.exceps.InitializationException;

class LogTransactionsThreadPoolTest {
	
	@Mock
	static
	ExecutionContextInfo executionContextInfo = null;
	
	@Mock
	static
	List<AIFraudSrvcResponseVO> fraudResponseVOList = null; 

	@Mock
	static
	TransBatchLoggingTask transBatchLoggingTask;
	
	static void initializeModelPipelines(String fmsMiInstanceId) throws StartupFailedException, InitializationException {
		ModelPipelinesInitializer.initializeModelPipelines(fmsMiInstanceId);
	}
	
	static void initFetchTransQuery() throws SQLException {
		com.i2c.mcp.batch.common.beans.ResponseInfo responseInfo =  DataFetchCommonService.getInstance().getDataFetchQuery(BetaModelExecutorConstants.FETCH_DATASET_GROUP_ID, BetaModelExecutorConstants.FMS_MI_INSTANCE_ID);
		String query = "";
		if (ResponseCodes.SUCCESS.equals(responseInfo.getResponseCode())) {
			query = responseInfo.getReturnData().toString();
		}else {
			query = BetaModelExecutorConstants.DEFAULT_LATEST_TRANS_TS_QUERY;
		}
		BetaModelExecutorConstants.LATEST_TRANS_TS_QUERY = query;
	}
	
	@BeforeAll
	static
	public void init() throws DatabasePoolInitializtionException, CacheException, SQLException, StartupFailedException, InitializationException, CommonBaseException   {
		AssignedRangeInfo assignedRangeInfo = new AssignedRangeInfo();
    	assignedRangeInfo.setEmptyRange(false);
    	assignedRangeInfo.setFrom(154765010);
    	assignedRangeInfo.setTo(154766009);
    	
    	GenericThreadPool.initializePool(BetaModelExecutorConstants.GENERIC_THREAD_POOL_SIZE);
		InternalModelExecutorTaskPool.initThreadPool(BetaModelExecutorConstants.INIT_AI_TASK_TP_INIT_SIZE, BetaModelExecutorConstants.MAX_AI_TASK_TP_SIZE);
		
		Map<String, String> INTERFACE_IDS_MAPPING = new ConcurrentHashMap<>();
		INTERFACE_IDS_MAPPING.put("AIDEV", "AIDEV");
		DatabaseHandler.initPool("BPCAI", INTERFACE_IDS_MAPPING.keySet(), "log4j2.properties",
					"D:\\workspace-sts\\BatchController\\resources\\Fail_Over_Plan_config_dev.xml", "D:\\workspace-sts\\BatchController\\resources\\mi.vm");
		ProfilingServicesCacheInitalizer.initializeProfilingCache(BetaModelExecutorConstants.CARDS_DATA_INSTANCE_ID, "113", BetaModelExecutorConstants.CACHE_INIT_TIME_OUT_MILI_SEC);
		initializeModelPipelines(BetaModelExecutorConstants.FMS_MI_INSTANCE_ID);

		Map<String, Map<String, String>> configurationParameter = new ConcurrentHashMap<>();
		Map<String, String> configurationParams1 = new ConcurrentHashMap<>();
		configurationParams1.put("PARAM_VALUE","2001");
		configurationParameter.put(BetaModelExecutorConstants.PARAM_ID_FETCH_DATASET_GROUP_ID,configurationParams1);
		Map<String, String> configurationParams2 = new ConcurrentHashMap<>();
		configurationParams2.put("PARAM_VALUE","N");
		configurationParameter.put(BetaModelExecutorConstants.PARAM_ID_FETCH_MARKER_FROM_DB,configurationParams2);
		configurationParameter.put(BetaModelExecutorConstants.PARAM_ID_DELETE_EXISTING_EVAL_TRANSACTIONS,configurationParams2);
		ConfigurationParameters configurationParameters = new ConfigurationParameters(configurationParameter);
		
        Timestamp ts=new Timestamp(-18000000);
        Date cutOffTime=new Date(ts.getTime()); 
        ts=new Timestamp(1672297140000L);
        Date nextExecutionDate=new Date(ts.getTime());
        ExecutionContextInfo executionContextInfo = new ExecutionContextInfo (1926047122, 94812562, "BetaModelExecutor_De", "M100", "113",
    			"BPCAI", "Beta Model Fraud Rules Executor Service", "Dev_Machine_23_123", "N", "Y", "N", 15, 30, "0", "N", cutOffTime,
    			nextExecutionDate, "Y", "L", 3, "DEBUG", 1000, 20, "com.i2c.ai.services.betamodelexecutor.BetaModelExecutorService",
    			30, 120, "A", "Y", configurationParameters, null, null, null, null, false);
        
		BetaModelExecutorContainer.initializeQueuesForInstance(BetaModelExecutorConstants.BETA_MODEL_CONTAINER_QUEUE_SIZE, executionContextInfo.getInstanceId());
    	FetchTransactionsThreadPool.initializePool("M100", BetaModelExecutorConstants.FETCH_TRANS_THREAD_POOL_SIZE);
    	EvaluateTransactionsThreadPool.initializePool("M100", BetaModelExecutorConstants.EVAL_TRANS_THREAD_POOL_SIZE);

        initFetchTransQuery();
        AbstractSubController subControllerFetchTransactions = new SubControllerFetchTransactions(assignedRangeInfo, executionContextInfo);
        AbstractSubController subControllerEvaluateTransactions = new SubControllerEvaluateTransactions(executionContextInfo, subControllerFetchTransactions);
		ResponseInfo response = subControllerFetchTransactions.call();
		if (response.getResponseCode() != "000") {
			throw new CommonBaseException("subControllerFetchTransactions exception");
		}
		
		response = subControllerEvaluateTransactions.call();
		if (response.getResponseCode() != "000") {
			throw new CommonBaseException("subControllerEvaluateTransactions exception");
		}


		fraudResponseVOList = BetaModelExecutorContainer.getInstance("M100").getNextEvaluatedFraudResponseVOList(BetaModelExecutorConstants.LOG_TRANS_BATCH_SIZE);
		transBatchLoggingTask = new TransBatchLoggingTask(executionContextInfo, fraudResponseVOList);
	}
	
	@Test
	void initializePooltest() {
		LogTransactionsThreadPool.initializePool("M100", BetaModelExecutorConstants.LOG_TRANS_THREAD_POOL_SIZE);
		assertEquals(BetaModelExecutorConstants.LOG_TRANS_THREAD_POOL_SIZE,LogTransactionsThreadPool.getinstanceBasedPoolSize("M100"),"Intialized ThreadPool should equal pool size");
	}
	
	@Test
	void processTaskExceptiontest() {
		LogTransactionsThreadPool.initializePool("M100", BetaModelExecutorConstants.LOG_TRANS_THREAD_POOL_SIZE);
		assertDoesNotThrow(()->LogTransactionsThreadPool.processTask("M100", transBatchLoggingTask),"Does not throw an exception");
	}
	
	@Test
	void processTaskReturntest() {
		LogTransactionsThreadPool.initializePool("M100", BetaModelExecutorConstants.LOG_TRANS_THREAD_POOL_SIZE);
		assertNotNull(LogTransactionsThreadPool.processTask("M100", transBatchLoggingTask),"Does not return null");
	}
}
