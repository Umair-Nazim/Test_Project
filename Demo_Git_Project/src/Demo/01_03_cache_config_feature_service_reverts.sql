-- mysql

BEGIN WORK;

DELETE FROM cache_key_dim1s WHERE cache_key='data_features';
DELETE FROM cache_key_dims WHERE cache_key='data_features';
DELETE FROM b_cache_grp1s WHERE cache_grp_id in ('StandaloneFeatureEngineering', 'StandaloneModelTraining');
DELETE FROM b_cache_keys WHERE cache_key='data_features';
DELETE FROM b_cache_grps WHERE cache_grp_id in ('StandaloneFeatureEngineering', 'StandaloneModelTraining');

COMMIT WORK;