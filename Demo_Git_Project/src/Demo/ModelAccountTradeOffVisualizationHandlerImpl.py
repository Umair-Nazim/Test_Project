"""
Authors: anadeem

Class Functions:
evaluateTradeOff
"""
import logging
import pandas as pd
import matplotlib.pyplot as plt

from aievaluation.bl.EvaluationVisualizationAbstractHandler import EvaluationVisualizationAbstractHandler
from aievaluation.utils.EvaluationUtils import EvaluationUtils
from aievaluation.utils.Constants import Constants
from aicommonspython.commonutils.CommonConstants import CommonConstants
from aicommonspython.commonutils.CommonUtilities import CommonUtilities
from commonexceps.CommonBaseException import CommonBaseException
from commonexceps.CommonInvalidArgumentException import CommonInvalidArgumentException


class ModelAccountTradeOffVisualizationHandlerImpl(EvaluationVisualizationAbstractHandler):
    """
    This file contains implementation class to save the tradeoff curve for account.
    """
    def __init__(self):
        self.logger = logging.getLogger(Constants.LOGGER_NAME)

    def evaluate_tradeoff(self, visualization_id, visualization_file_path, pred_and_label_df,
                          model_evaluation_request_info, visualization_params_map, class_labels):
        """
        :param visualization_id: unique id for tradeoff curve visualization
        :param visualization_file_path: path for saving tradeoff curve
        :param pred_and_label_df: pandas converted pred_and_label_df
        :param model_evaluation_request_info: object containing all general configurations
        :param visualization_params_map: visualization related config object
        :param class_labels: dict of class labels e.g. {'prob_class_id': 1, 'neg_class_id': 0}
        :return: Image path for tradeoff curve visualization
        """
        try:
            execution_context_info = model_evaluation_request_info.execution_context_info
            param_value_mapping = execution_context_info.param_value_mapping
            label_col = execution_context_info.label_column

            self.logger.info('Going to calculate the TradeOff Curve by Account.')
            if not isinstance(pred_and_label_df, pd.DataFrame):
                self.logger.error('CommonInvalidArgumentException occurred while validating pred_and_label_df')
                raise CommonInvalidArgumentException("predAndLabelDF DataFrame is not of valid type,"
                                                     " not evaluating tradeoff curve for Account")
            else:
                is_all_tradeoff_empty, fig, tradeoff_dfs = EvaluationUtils.get_tradeoff_fig_with_subplots(
                    pred_and_label_df,
                    class_labels,
                    label_col,
                    visualization_id,
                    visualization_params_map,
                    param_value_mapping
                )

                if is_all_tradeoff_empty:
                    self.logger.warning(f"Tradeoff curve cannot be made for visualization id: {visualization_id},"
                                        f" since either aggregated_frauds_by_feature or fp_odds_by_feature"
                                        f" list is empty/null")
                    return self.get_response_info(Constants.EMPTY_FILE_PATH)

                self.logger.info(f"Going to create dir_hierarchy for dir_hierarchy_path:{visualization_file_path}"
                                 f" if it does not exists already.")

                visualization_dir_path = (CommonConstants.FORWARD_SLASH_TAG
                                          .join(visualization_file_path
                                                .split(CommonConstants.FORWARD_SLASH_TAG)[:-1]) +
                                          CommonConstants.FORWARD_SLASH_TAG)
                CommonUtilities.create_dir_hierarchy(visualization_dir_path)

                self.logger.info("Going to save tradeoff data in csv file")
                visualization_data_path = EvaluationUtils.save_tradeoff_data(
                    visualization_file_path,
                    tradeoff_dfs
                )
                self.logger.info(f"Saved tradeoff data for visualization id:{visualization_id}"
                                 f" to path: {visualization_data_path}")

                visualization_file_path = EvaluationUtils.save_tradeoff_curve(
                    fig,
                    visualization_file_path,
                    visualization_params_map,
                    param_value_mapping
                )
                self.logger.info(f"Saved tradeoff curve for visualization id:{visualization_id}"
                                 f" to path: {visualization_file_path}")

                return self.get_response_info(visualization_file_path)
        except CommonInvalidArgumentException as exp:
            raise CommonBaseException(exp)
        except CommonBaseException as exp:
            raise CommonBaseException(exp)
        except Exception as exp:
            self.logger.error('Exception occurred while evaluating tradeoff curve for Account')
            raise CommonBaseException(exp)
