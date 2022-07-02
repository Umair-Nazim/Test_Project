--Greenplum;
DROP VIEW IF EXISTS v_sfraud_det;
CREATE VIEW v_sfraud_det(
		trace_audit_no,
        trans_date,
        trans_time,
        card_prg_id,
        card_prg_name,
        card_no,
        Name,
        email,
        phone_no,
        mobile_no,
        card_balance,
        ledger_balance,
        device_type,
        device_type_abrv,
        service_id,
        service_name,
        fparam_code,
        fparam_abrv,
        param_name,
        merchant_name,
        card_aceptor_code,
        merchant_cat_code,
        merchant_cat_name,
        merchant_location,
        amount_requested,
        program_category,
        card_ref_no,
        ads_id,
        resp_code,
        param_category,
        amount_processed,
        iso_message_type,
		receiver_name
)  as
SELECT
    tr.trace_audit_no as trace_audit_no,
    tr.trans_date as trans_date,
    tr.trans_time as trans_time,
    cp.card_prg_id as card_prg_id,
    cp.card_prg_name as card_prg_name,
    tr.card_no as card_no,
    COALESCE(trim(crds.first_name1), '')||' '||COALESCE(trim(crds.last_name1), '') as Name,
    COALESCE(trim(crds.email), ' -') as email,
    COALESCE(crds.home_phone_no, ' -') as phone_no,
    crds.mobile_no as mobile_no,
    0 as card_balance,
    0 as ledger_balance,
    tr.device_type as device_type,
    dtyps.device_type_abrv as device_type_abrv,
    srvs.service_id as service_id,
    srvs.service_abrv as service_name,
    fparam.fparam_code as fparam_code,
    fparam.fparam_abrv as fparam_abrv,
    fparam.fparam_name as param_name,
    tr.merchant_name as merchant_name,
    tr.card_aceptor_code as card_aceptor_code,
    tr.merchant_cat_code as merchant_cat_code,
    mcc.merchant_cat_name as merchant_cat_name,
    CASE
        WHEN tr.merchant_name IS NULL
        AND tr.city IS NULL
        AND tr.state IS NULL
        AND tr.country_code IS NULL
        THEN '-'
        ELSE (COALESCE(tr.merchant_name, '') ||', ' || COALESCE(tr.city, '') ||', ' || COALESCE
            (tr.state,'') || ', ' || COALESCE (tr.country_code,'')||'.')
    END as merchant_location,
    CASE
        WHEN tr.response_code = '00'
        THEN tr.amount_processed
        ELSE COALESCE(tr.amount_requested * COALESCE(tr.ex_rate_bill, 1), 0)
    END as amount_requested,
    cp.program_category as program_category,
    crds.branch_fiid as card_ref_no,
    tr1s.ads_id as ads_id,
    tr.response_code as resp_code,
    pc.param_category as param_category,
    tr.amount_processed as amount_processed,
    tr.iso_message_type as iso_message_type,
    tr.receiver_name as receiver_name
FROM
    trans_requests tr
    inner join card_programs cp on tr.card_prg_id = cp.card_prg_id AND tr.fparam_code IS NOT NULL AND (tr.response_code != 'HI' OR tr.response_code IS NULL)
    inner join trans_request1s tr1s on tr.trace_audit_no=tr1s.trace_audit_no
    inner join services srvs on tr.service_id = srvs.service_id
    inner join fraud_parameters fparam on fparam.fparam_code = tr.fparam_code
    inner join device_types dtyps on tr.device_type = dtyps.device_type
    inner join merchant_cat_codes mcc on mcc.merchant_cat_code = tr.merchant_cat_code
    inner join cards crds on crds.card_no = tr.card_no
    inner join param_categories pc on fparam.param_category=pc.param_category
where tr.trace_audit_no is not Null;

GRANT SELECT ON v_sfraud_det to app_role;
GRANT SELECT ON v_sfraud_det to data_select_role;