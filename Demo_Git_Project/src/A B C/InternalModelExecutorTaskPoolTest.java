package com.i2c.ai.services.betamodelexecutor.threadpool;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Callable;
import java.util.concurrent.ConcurrentHashMap;

import org.junit.jupiter.api.Test;

import com.i2c.ai.common.beans.AIFraudSrvcRequestVO;
import com.i2c.ai.common.beans.ResponseInfo;
import com.i2c.ai.common.buildprofilingstats.utils.ModelPipelinesInitializer;
import com.i2c.ai.common.buildprofilingstats.utils.ProfilingServicesCacheInitalizer;
import com.i2c.ai.common.datafetch.DataFetchCommonService;
import com.i2c.ai.common.exceps.CacheException;
import com.i2c.ai.common.utils.AttributeConstants;
import com.i2c.ai.common.utils.CommonAIConstants;
import com.i2c.ai.common.utils.CommonAIUtils;
import com.i2c.ai.common.utils.FraudEvaluatorHelper;
import com.i2c.ai.common.utils.ResponseCodes;
import com.i2c.ai.services.betamodelexecutor.dao.AbstractBetaModelExecutorDao;
import com.i2c.ai.services.betamodelexecutor.evaluator.FraudEvaluator;
import com.i2c.ai.services.betamodelexecutor.evaluator.InternalModelEvaluator;
import com.i2c.ai.services.betamodelexecutor.utils.BetaModelExecutorConstants;
import com.i2c.mcp.batch.common.excep.StartupFailedException;
import com.i2c.mcp.batch.services.databasehandler.DatabaseHandler;
import com.i2c.mcp.batch.services.databasehandler.exceps.DatabasePoolInitializtionException;
import com.i2c.services.common.exceps.CommonBaseException;
import com.i2c.services.common.exceps.InitializationException;

class InternalModelExecutorTaskPoolTest {
	
	private void populateModelEvaluationTaskList(List<Callable<Object>> evaluationTaskList,Map<String, List<String>> evalTypeBasedRulesListMap,AIFraudSrvcRequestVO aiFraudSrvcRqstVO, Map<String, Object> transObject,Map<String, String> mapModelRule) 
			throws CommonBaseException {
		for (Map.Entry<String, List<String>> evalTypeBasedRulesListEntry : evalTypeBasedRulesListMap.entrySet()) {
			String modelEvalType = evalTypeBasedRulesListEntry.getKey();
			if (!evalTypeBasedRulesListEntry.getValue().isEmpty() && BetaModelExecutorConstants.MODEL_EVAL_TYPE_INTERNAL.equals(modelEvalType)) {
					evaluationTaskList.add(InternalModelEvaluator.getInstance(aiFraudSrvcRqstVO, mapModelRule, transObject));
			}
		}
	}
	
	private void FetchTransQuery() throws SQLException {
		com.i2c.mcp.batch.common.beans.ResponseInfo responseInfo =  DataFetchCommonService.getInstance().getDataFetchQuery(BetaModelExecutorConstants.FETCH_DATASET_GROUP_ID, BetaModelExecutorConstants.FMS_MI_INSTANCE_ID);
		String query = "";
		if (ResponseCodes.SUCCESS.equals(responseInfo.getResponseCode())) {
			query = responseInfo.getReturnData().toString();
		}else {
			query = BetaModelExecutorConstants.DEFAULT_LATEST_TRANS_TS_QUERY;
		}
		BetaModelExecutorConstants.LATEST_TRANS_TS_QUERY = query;
	}
	
	private AIFraudSrvcRequestVO populateAIFraudSrvcRequestVO(Map<String, Object> trans) {
		AIFraudSrvcRequestVO fraudSrvcRequestVO = new AIFraudSrvcRequestVO();
		fraudSrvcRequestVO.setTraceAuditNo(String.valueOf(trans.get(AttributeConstants.TRACE_AUDIT_NO)));
		fraudSrvcRequestVO.setFiId(String.valueOf(trans.get(CommonAIConstants.COL_FI_ID)));
		fraudSrvcRequestVO.setInstanceId(String.valueOf(trans.get(CommonAIConstants.COL_INST_ID)));
		fraudSrvcRequestVO.setSwitchType(String.valueOf(trans.get(CommonAIConstants.COL_SWITCH_TYPE)));
		fraudSrvcRequestVO.setSwitchRegion(String.valueOf(trans.get(CommonAIConstants.COL_SWITCH_REGION)));
		fraudSrvcRequestVO.setCardBin(String.valueOf(trans.get(CommonAIConstants.COL_CARD_BIN)));
		fraudSrvcRequestVO.setCardPrgId(String.valueOf(trans.get(CommonAIConstants.COL_CARD_PRG_ID)));
		return fraudSrvcRequestVO;
	}
	
	private void initializeModelPipelines(String fmsMiInstanceId) throws StartupFailedException, InitializationException {
		ModelPipelinesInitializer.initializeModelPipelines(fmsMiInstanceId);
	}

	@Test
	void initThreadPooltest() {
		ResponseInfo responseInfo = new ResponseInfo();
        responseInfo.setResponseCode("000");
        responseInfo.setResponseDescription("Success");
        assertEquals("Result equals Success response code",responseInfo.getResponseCode(),InternalModelExecutorTaskPool.initThreadPool(BetaModelExecutorConstants.INIT_AI_TASK_TP_INIT_SIZE, BetaModelExecutorConstants.MAX_AI_TASK_TP_SIZE).getResponseCode());
	}

	@Test
	void invokeTasksInParalleltest() throws StartupFailedException, DatabasePoolInitializtionException, CacheException, SQLException, InitializationException, CommonBaseException  {
		GenericThreadPool.initializePool(BetaModelExecutorConstants.GENERIC_THREAD_POOL_SIZE);
		InternalModelExecutorTaskPool.initThreadPool(BetaModelExecutorConstants.INIT_AI_TASK_TP_INIT_SIZE, BetaModelExecutorConstants.MAX_AI_TASK_TP_SIZE);
		Map<String, String> INTERFACE_IDS_MAPPING = new ConcurrentHashMap<>();
		INTERFACE_IDS_MAPPING.put("AIDEV", "AIDEV");
		DatabaseHandler.initPool("BPCAI", INTERFACE_IDS_MAPPING.keySet(), "log4j2.properties",
					"D:\\workspace-sts\\BatchController\\resources\\Fail_Over_Plan_config_dev.xml", "D:\\workspace-sts\\BatchController\\resources\\mi.vm");
		ProfilingServicesCacheInitalizer.initializeProfilingCache(BetaModelExecutorConstants.CARDS_DATA_INSTANCE_ID, "113", BetaModelExecutorConstants.CACHE_INIT_TIME_OUT_MILI_SEC);
		initializeModelPipelines(BetaModelExecutorConstants.FMS_MI_INSTANCE_ID);
		FetchTransQuery();
		FraudEvaluator fraudEvaluator = new FraudEvaluator();
		Connection secondaryConnection = DatabaseHandler.getSecondaryDbConnection("BPCAI", "M100");
		Collection<Map<String, Object>> transList = AbstractBetaModelExecutorDao.getInstance().fetchLatestTransactions(154765010,154766009, secondaryConnection);
		DatabaseHandler.returnConnection(secondaryConnection);
		Map<String, Object> transObject = transList.iterator().next();
		
		for(Map<String, Object> transMap: transList){
			if(!CommonAIUtils.isNullOrEmptyMap(transMap) ) {
				transObject = transMap;
				break;
			}
		}
		AIFraudSrvcRequestVO aiFraudSrvcRqstVO = populateAIFraudSrvcRequestVO(transObject);
		List<String> listflexBasedRules = new ArrayList<>();
		Map<String, String> mapModelRule = new ConcurrentHashMap<>();
		Map<String, List<String>> evalTypeBasedRulesListMap = new ConcurrentHashMap<>();
		List<Callable<Object>> evaluationTaskList = new ArrayList<>();
		FraudEvaluatorHelper fraudEvalutorHelper = new FraudEvaluatorHelper();
		Map<String, Map<String, String>> aiRules = fraudEvalutorHelper.loadRequestBasedRules(aiFraudSrvcRqstVO, BetaModelExecutorConstants.MI_INSTANCE_ID);
		for (Map<String, String> rule : aiRules.values()) {
			if (fraudEvaluator.isRuleCriteriaFulfilled(aiFraudSrvcRqstVO, transObject, rule)) {					
				fraudEvalutorHelper.populateEvalTypeRuleMapAndMapModelRule(rule, mapModelRule,evalTypeBasedRulesListMap,listflexBasedRules, BetaModelExecutorConstants.MI_INSTANCE_ID);
			}
		}
		populateModelEvaluationTaskList(evaluationTaskList, evalTypeBasedRulesListMap, aiFraudSrvcRqstVO,transObject, mapModelRule);
		assertNotNull("Result is not null",InternalModelExecutorTaskPool.invokeTasksInParallel(evaluationTaskList));	
	}
}
