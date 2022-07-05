-- mysql

BEGIN WORK;

INSERT INTO b_cache_grps (cache_grp_id, cache_grp_desc, is_active) VALUES ('StandaloneFeatureEngineering', 'StandaloneFeatureEngineering', 'Y');
INSERT INTO b_cache_grps (cache_grp_id, cache_grp_desc, is_active) VALUES ('StandaloneModelTraining', 'StandaloneModelTraining', 'Y');

INSERT INTO b_cache_keys (cache_key, cache_query, cache_refresh_query, cache_data_src_id, is_active) VALUES ('data_features', 'select * from data_features where is_active = ''Y''', null, 'D', 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'data_features', 'FMIU', null, 'Y');
INSERT INTO cache_key_dims (cache_key, dim_id, is_active) VALUES ('data_features', 'data_id', 'Y');
INSERT INTO cache_key_dim1s (cache_key, dim_id, table_name, column_name, seq_no, is_active) VALUES ('data_features', 'data_id', 'data_features', 'data_id', 1, 'Y');

INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'age_groups', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'age_of_card_groups', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'ai_currency_exch_rates_to_usd', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'amount_outlier', '246', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'atm_trans_avg_interval_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'attribute_preprocesses', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'attr_preprocess_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'bank_account_no_routing_no_risk_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_attr_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_cache_keys', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_dataset_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_data_samplings', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_data_sampling_criterias', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_data_sampling_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_features', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_feature_eng_ops', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_feature_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_preprocess_ops', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'b_split_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'cache_key_dim1s', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'cache_key_dims', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_age_risk_groups', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', '113', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', '150', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', '246', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', '324', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', '340', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', '364', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', '396', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', 'G246', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_prg_to_currency_code', 'G325', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_reissue_flag_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'card_status_change_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'check_commonality_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'check_non_fraud_trans_interval_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'credit_debit_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'currency_code_to_iso_currency_code', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'cust_prof_updt_flag_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'dataset_grp_samplings', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'dataset_grp_sampling_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'data_attribute_ids', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'data_hitrates', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'data_pipelines', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'data_sampling_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'data_split_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'day_intervals', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'feature_cache_keys', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'feature_ckey_value_cols', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'feature_eng_op_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'feature_operands', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'feature_operational_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'feature_sets', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'feature_set_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'iso_currency_code_to_currency_code', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'iso_message_type_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'mcc_risk_mappings', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'mcc_risk_portfolio', 'FMIU', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'merchant_cat_code_to_merchant_group_id', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'merchant_cat_code_to_merchant_group_id', '246', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'merchant_cat_code_to_merchant_group_id', 'G246', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'preprocess_op_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'profile_update_flag_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'routing_no_risk_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'service_id_to_device_type', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'spending_upperbound_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'train_datasets', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'train_dataset_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'train_dataset_grps', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'train_dataset_grp_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneFeatureEngineering', 'zip_to_lat_long', '113', null, 'Y');

INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'data_features', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'age_groups', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'age_of_card_groups', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'ai_currency_exch_rates_to_usd', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'ai_model1s', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'ai_models', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'ai_model_grps', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'amount_outlier', '246', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'atm_trans_avg_interval_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'atm_trans_avg_interval_map', 'FMIUq', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'attribute_preprocesses', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'attr_preprocess_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'bank_account_no_routing_no_risk_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_attr_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_cache_keys', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_cross_validations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_dataset_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_data_samplings', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_data_sampling_criterias', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_data_sampling_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_evaluation_classes', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_evaluation_metrics', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_evaluation_visualizations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_features', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_feature_eng_ops', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_feature_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_metric_levels', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_model_algos', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_preprocess_ops', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_split_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'b_transformation_types', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'cache_key_dim1s', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'cache_key_dims', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_age_risk_groups', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', '113', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', '150', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', '246', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', '324', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', '340', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', '364', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', '396', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', 'G246', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_prg_to_currency_code', 'G325', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_reissue_flag_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'card_status_change_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'check_commonality_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'check_non_fraud_trans_interval_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'credit_debit_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'currency_code_to_iso_currency_code', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'cust_prof_updt_flag_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'dataset_grp_samplings', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'dataset_grp_sampling_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'data_attribute_ids', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'data_hitrates', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'data_pipelines', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'data_sampling_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'data_split_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'day_intervals', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_cache_keys', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_ckey_value_cols', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_eng_op_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_operands', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_operational_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_sets', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_set_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_transformations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'feature_transformation_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'iso_currency_code_to_currency_code', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'iso_message_type_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'mcc_risk_mappings', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'mcc_risk_portfolio', 'FMIU', null, 'N');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'merchant_cat_code_to_merchant_group_id', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'merchant_cat_code_to_merchant_group_id', '246', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'merchant_cat_code_to_merchant_group_id', 'G246', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'metric_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_algo_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_attribute_preprocesses', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_attr_preprocess_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_classes', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_cross_validations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_cross_val_param_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_data_samplings', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_data_sampling_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_evaluations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_features', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_feature_transformations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_feature_transformation_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_metric_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_pipelines', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_split_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_transformations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_transformation_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_visualizations', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'model_visualization_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'preprocess_op_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'profile_update_flag_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'routing_no_risk_map', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'service_id_to_device_type', '113', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'spending_upperbound_mapping', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'train_datasets', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'train_dataset_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'train_dataset_grps', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'train_dataset_grp_details', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'transformation_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'visualization_config_params', 'FMIU', null, 'Y');
INSERT INTO b_cache_grp1s (cache_grp_id, cache_key, instance_id, query_filter, is_active) VALUES ('StandaloneModelTraining', 'zip_to_lat_long', '113', null, 'Y');

COMMIT WORK;