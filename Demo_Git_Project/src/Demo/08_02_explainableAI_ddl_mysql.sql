-- MySql

BEGIN WORK;

CREATE TABLE b_explainers(
    sr_no INT NOT NULL AUTO_INCREMENT,
    explainer_id INT NOT NULL,
    explainer_name VARCHAR(100) NULL,
    impl_class_name VARCHAR(512) NOT NULL,
    is_active CHAR(1) DEFAULT 'Y' NULL,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL,
    dbit_flag CHAR(1) NULL,
    last_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NULL,
    rec_no BIGINT NULL,

    PRIMARY KEY ( explainer_id ),
    CONSTRAINT uk_b_explainer_sr_no UNIQUE (sr_no)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE model_explainers(
    sr_no INT NOT NULL AUTO_INCREMENT,
    model_code INT NOT NULL,
    explainer_id INT NOT NULL,
    is_active CHAR(1) DEFAULT 'Y' NULL,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL,
    dbit_flag CHAR(1) NULL,
    last_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NULL,
    rec_no BIGINT NULL,

    PRIMARY KEY ( sr_no ),
    CONSTRAINT uk_model_explainers_eid_mcode UNIQUE ( explainer_id,  model_code ),
    CONSTRAINT fk_model_explainers_ai_model1s FOREIGN KEY (model_code) REFERENCES `ai_model1s` (`model_code`),
    CONSTRAINT fk_model_explainers_b_explainers FOREIGN KEY (explainer_id) REFERENCES `b_explainers` (`explainer_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE model_explainer_config_params(
    sr_no INT NOT NULL AUTO_INCREMENT,
    model_code INT NOT NULL,
    explainer_id INT NOT NULL,
    param_id VARCHAR(100) NOT NULL,
    param_val VARCHAR(255) DEFAULT NULL,
    data_type_code CHAR(1),
    is_active CHAR(1) DEFAULT 'Y' NULL,
    created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP NULL,
    dbit_flag CHAR(1) NULL,
    last_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NULL,
    rec_no BIGINT NULL,

    PRIMARY KEY ( sr_no ),
    CONSTRAINT uk_model_explainer_config_params_mcode_eid_pid UNIQUE ( model_code, explainer_id, param_id ),
    CONSTRAINT fk_model_explainer_config_params_ai_model1s FOREIGN KEY (model_code) REFERENCES `ai_model1s` (`model_code`),
    CONSTRAINT fk_model_explainer_config_params_b_explainers FOREIGN KEY (explainer_id) REFERENCES `b_explainers` (`explainer_id`),
    CONSTRAINT fk_model_explainer_config_params_b_data_types FOREIGN KEY (data_type_code) REFERENCES `b_data_types` (`data_type_code`),
    CONSTRAINT fk_model_explainer_config_params_config_params FOREIGN KEY (param_id) REFERENCES `config_params` (`param_id`)
)
ENGINE=InnoDB DEFAULT CHARSET=latin1;



Create table b_explainerh
(
action_no integer primary key NOT NULL
,sr_no INT NOT NULL
,explainer_id INT NOT NULL
,explainer_name varchar(100) NULL
,impl_class_name varchar(512) NOT NULL
,is_active char(1) NULL
,created_on TIMESTAMP NULL
,dbit_flag char(1) NULL
,last_updated_at TIMESTAMP NULL
);

insert into oj_b_cache_dbit_maps (dbit_map_id, dbit_map_name, dbit_map_abrv, dbit_map_detail, display_order) values ('b_explainers','b_explainers','b_explainers','b_explainers',1);

DELIMITER $$
create trigger b_explaineri before insert on b_explainers for each row
begin 
Declare v_rec_no bigint; 
call gen_rec_no('I','b_explainers',v_rec_no); 
insert into b_explainerh (action_no  ,sr_no ,explainer_id ,explainer_name ,impl_class_name ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.explainer_id ,new.explainer_name ,new.impl_class_name ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at ); 
set new.rec_no=v_rec_no; 
Update central_log set rec_no = v_rec_no where action_no = v_rec_no; 
UPDATE oj_b_cache_dbit_maps SET last_updated_at = NOW() WHERE dbit_map_id ='b_explainers'; 
End$$ 
DELIMITER ;

DELIMITER $$
     
create trigger b_explaineru before update on b_explainers for each row 
Begin
Declare v_rec_no bigint;
IF ((new.sr_no <> old.sr_no) OR (new.sr_no is null and old.sr_no is not null) OR (new.sr_no is not null and old.sr_no is null))
OR ((new.explainer_id <> old.explainer_id) OR (new.explainer_id is null and old.explainer_id is not null) OR (new.explainer_id is not null and old.explainer_id is null))
OR ((new.explainer_name <> old.explainer_name) OR (new.explainer_name is null and old.explainer_name is not null) OR (new.explainer_name is not null and old.explainer_name is null))
OR ((new.impl_class_name <> old.impl_class_name) OR (new.impl_class_name is null and old.impl_class_name is not null) OR (new.impl_class_name is not null and old.impl_class_name is null))
OR ((new.is_active <> old.is_active) OR (new.is_active is null and old.is_active is not null) OR (new.is_active is not null and old.is_active is null))
OR ((new.created_on <> old.created_on) OR (new.created_on is null and old.created_on is not null) OR (new.created_on is not null and old.created_on is null))
OR ((new.dbit_flag <> old.dbit_flag) OR (new.dbit_flag is null and old.dbit_flag is not null) OR (new.dbit_flag is not null and old.dbit_flag is null))
OR ((new.last_updated_at <> old.last_updated_at) OR (new.last_updated_at is null and old.last_updated_at is not null) OR (new.last_updated_at is not null and old.last_updated_at is null))
THEN
call gen_rec_no('U','b_explainers',v_rec_no); 
IF new.rec_no IS NULL THEN
set new.rec_no=v_rec_no;
Update central_log set rec_no = v_rec_no where action_no = v_rec_no;
insert into b_explainerh (action_no ,sr_no ,explainer_id ,explainer_name ,impl_class_name ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,old.sr_no ,old.explainer_id ,old.explainer_name ,old.impl_class_name ,old.is_active ,old.created_on ,old.dbit_flag ,old.last_updated_at );
call gen_rec_no('U','b_explainers',v_rec_no); 
insert into b_explainerh (action_no ,sr_no ,explainer_id ,explainer_name ,impl_class_name ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.explainer_id ,new.explainer_name ,new.impl_class_name ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at );
ELSE
Update central_log set rec_no = new.rec_no where action_no = v_rec_no;
insert into b_explainerh (action_no ,sr_no ,explainer_id ,explainer_name ,impl_class_name ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.explainer_id ,new.explainer_name ,new.impl_class_name ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at );
END IF;
END IF;
UPDATE oj_b_cache_dbit_maps SET last_updated_at = NOW() WHERE dbit_map_id ='b_explainers'; 
End$$ 
DELIMITER ;

DELIMITER $$

create trigger b_explainerd before delete on b_explainers for each row 
 begin 
 Declare v_rec_no bigint; 
Declare is_null CHAR(1);
 Set v_rec_no = OLD.rec_no; 
IF v_rec_no IS NULL THEN
SET  is_null = 'Y';
END IF;
call gen_rec_no('D','b_explainers',v_rec_no); 
IF is_null = 'Y' THEN
insert into b_explainerh (action_no ,sr_no ,explainer_id ,explainer_name ,impl_class_name ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,old.sr_no ,old.explainer_id ,old.explainer_name ,old.impl_class_name ,old.is_active ,old.created_on ,old.dbit_flag ,old.last_updated_at );
update central_log set rec_no = v_rec_no where action_no = v_rec_no;
END IF;
INSERT INTO oj_cdel_rec_info (table_name,rec_no,del_rec_srno) VALUES ('b_explainers',old.rec_no, old.sr_no);
End$$ 
DELIMITER ;


Create table model_explainerh
(
action_no integer primary key NOT NULL
,sr_no INT NOT NULL
,model_code INT NOT NULL
,explainer_id INT NOT NULL
,is_active char(1) NULL
,created_on TIMESTAMP NULL
,dbit_flag char(1) NULL
,last_updated_at TIMESTAMP NULL
);

insert into oj_b_cache_dbit_maps (dbit_map_id, dbit_map_name, dbit_map_abrv, dbit_map_detail, display_order) values ('model_explainers','model_explainers','model_explainers','model_explainers',1);

DELIMITER $$
create trigger model_explaineri before insert on model_explainers for each row
begin 
Declare v_rec_no bigint; 
call gen_rec_no('I','model_explainers',v_rec_no); 
insert into model_explainerh (action_no  ,sr_no ,model_code ,explainer_id ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.model_code ,new.explainer_id ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at ); 
set new.rec_no=v_rec_no; 
Update central_log set rec_no = v_rec_no where action_no = v_rec_no; 

UPDATE oj_b_cache_dbit_maps SET last_updated_at = NOW() WHERE dbit_map_id ='model_explainers'; 
End$$ 
DELIMITER ;

DELIMITER $$
     
create trigger model_explaineru before update on model_explainers for each row 
Begin
Declare v_rec_no bigint;
IF ((new.sr_no <> old.sr_no) OR (new.sr_no is null and old.sr_no is not null) OR (new.sr_no is not null and old.sr_no is null))
OR ((new.model_code <> old.model_code) OR (new.model_code is null and old.model_code is not null) OR (new.model_code is not null and old.model_code is null))
OR ((new.explainer_id <> old.explainer_id) OR (new.explainer_id is null and old.explainer_id is not null) OR (new.explainer_id is not null and old.explainer_id is null))
OR ((new.is_active <> old.is_active) OR (new.is_active is null and old.is_active is not null) OR (new.is_active is not null and old.is_active is null))
OR ((new.created_on <> old.created_on) OR (new.created_on is null and old.created_on is not null) OR (new.created_on is not null and old.created_on is null))
OR ((new.dbit_flag <> old.dbit_flag) OR (new.dbit_flag is null and old.dbit_flag is not null) OR (new.dbit_flag is not null and old.dbit_flag is null))
OR ((new.last_updated_at <> old.last_updated_at) OR (new.last_updated_at is null and old.last_updated_at is not null) OR (new.last_updated_at is not null and old.last_updated_at is null))
THEN
call gen_rec_no('U','model_explainers',v_rec_no); 
IF new.rec_no IS NULL THEN
set new.rec_no=v_rec_no;
Update central_log set rec_no = v_rec_no where action_no = v_rec_no;
insert into model_explainerh (action_no ,sr_no ,model_code ,explainer_id ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,old.sr_no ,old.model_code ,old.explainer_id ,old.is_active ,old.created_on ,old.dbit_flag ,old.last_updated_at );
call gen_rec_no('U','model_explainers',v_rec_no); 
insert into model_explainerh (action_no ,sr_no ,model_code ,explainer_id ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.model_code ,new.explainer_id ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at );
ELSE
Update central_log set rec_no = new.rec_no where action_no = v_rec_no;
insert into model_explainerh (action_no ,sr_no ,model_code ,explainer_id ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.model_code ,new.explainer_id ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at );
END IF;
END IF;

UPDATE oj_b_cache_dbit_maps SET last_updated_at = NOW() WHERE dbit_map_id ='model_explainers'; 
End$$ 
DELIMITER ;

DELIMITER $$
     
create trigger model_explainerd before delete on model_explainers for each row 
 begin 
 Declare v_rec_no bigint; 
Declare is_null CHAR(1);
 Set v_rec_no = OLD.rec_no; 
IF v_rec_no IS NULL THEN
SET  is_null = 'Y';
END IF;
call gen_rec_no('D','model_explainers',v_rec_no); 
IF is_null = 'Y' THEN
insert into model_explainerh (action_no ,sr_no ,model_code ,explainer_id ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,old.sr_no ,old.model_code ,old.explainer_id ,old.is_active ,old.created_on ,old.dbit_flag ,old.last_updated_at );
update central_log set rec_no = v_rec_no where action_no = v_rec_no;
END IF;

INSERT INTO oj_cdel_rec_info (table_name,rec_no,del_rec_srno) VALUES ('model_explainers',old.rec_no, old.sr_no);
End$$ 
DELIMITER ;

Create table model_explainer_config_paramh
(
action_no integer primary key
,sr_no INT NOT NULL
,model_code INT NOT NULL
,explainer_id INT NOT NULL
,param_id varchar(100) NOT NULL
,param_val varchar(255) NULL
,data_type_code char(1) NULL
,is_active char(1) NULL
,created_on TIMESTAMP NULL
,dbit_flag char(1) NULL
,last_updated_at TIMESTAMP NULL
);

insert into oj_b_cache_dbit_maps (dbit_map_id, dbit_map_name, dbit_map_abrv, dbit_map_detail, display_order) values ('model_explainer_cnfg_prms','model_explainer_config_params','mdl_explnr_cnfg_prms','model_explainer_config_params',1);

DELIMITER $$
create trigger model_explainer_config_parami before insert on model_explainer_config_params for each row
begin 
Declare v_rec_no bigint; 
call gen_rec_no('I','model_explainer_config_params',v_rec_no); 
insert into model_explainer_config_paramh (action_no  ,sr_no ,model_code ,explainer_id ,param_id ,param_val ,data_type_code ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.model_code ,new.explainer_id ,new.param_id ,new.param_val ,new.data_type_code ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at ); 
set new.rec_no=v_rec_no; 
Update central_log set rec_no = v_rec_no where action_no = v_rec_no; 
UPDATE oj_b_cache_dbit_maps SET last_updated_at = NOW() WHERE dbit_map_id ='model_explainer_cnfg_prms'; 
End$$ 
DELIMITER ;

DELIMITER $$

create trigger model_explainer_config_paramu before update on model_explainer_config_params for each row 
Begin
Declare v_rec_no bigint;
IF ((new.sr_no <> old.sr_no) OR (new.sr_no is null and old.sr_no is not null) OR (new.sr_no is not null and old.sr_no is null))
OR ((new.model_code <> old.model_code) OR (new.model_code is null and old.model_code is not null) OR (new.model_code is not null and old.model_code is null))
OR ((new.explainer_id <> old.explainer_id) OR (new.explainer_id is null and old.explainer_id is not null) OR (new.explainer_id is not null and old.explainer_id is null))
OR ((new.param_id <> old.param_id) OR (new.param_id is null and old.param_id is not null) OR (new.param_id is not null and old.param_id is null))
OR ((new.param_val <> old.param_val) OR (new.param_val is null and old.param_val is not null) OR (new.param_val is not null and old.param_val is null))
OR ((new.data_type_code <> old.data_type_code) OR (new.data_type_code is null and old.data_type_code is not null) OR (new.data_type_code is not null and old.data_type_code is null))
OR ((new.is_active <> old.is_active) OR (new.is_active is null and old.is_active is not null) OR (new.is_active is not null and old.is_active is null))
OR ((new.created_on <> old.created_on) OR (new.created_on is null and old.created_on is not null) OR (new.created_on is not null and old.created_on is null))
OR ((new.dbit_flag <> old.dbit_flag) OR (new.dbit_flag is null and old.dbit_flag is not null) OR (new.dbit_flag is not null and old.dbit_flag is null))
OR ((new.last_updated_at <> old.last_updated_at) OR (new.last_updated_at is null and old.last_updated_at is not null) OR (new.last_updated_at is not null and old.last_updated_at is null))
THEN
call gen_rec_no('U','model_explainer_config_params',v_rec_no); 
IF new.rec_no IS NULL THEN
set new.rec_no=v_rec_no;
Update central_log set rec_no = v_rec_no where action_no = v_rec_no;
insert into model_explainer_config_paramh (action_no ,sr_no ,model_code ,explainer_id ,param_id ,param_val ,data_type_code ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,old.sr_no ,old.model_code ,old.explainer_id ,old.param_id ,old.param_val ,old.data_type_code ,old.is_active ,old.created_on ,old.dbit_flag ,old.last_updated_at );
call gen_rec_no('U','model_explainer_config_params',v_rec_no); 
insert into model_explainer_config_paramh (action_no ,sr_no ,model_code ,explainer_id ,param_id ,param_val ,data_type_code ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.model_code ,new.explainer_id ,new.param_id ,new.param_val ,new.data_type_code ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at );
ELSE
Update central_log set rec_no = new.rec_no where action_no = v_rec_no;
insert into model_explainer_config_paramh (action_no ,sr_no ,model_code ,explainer_id ,param_id ,param_val ,data_type_code ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,new.sr_no ,new.model_code ,new.explainer_id ,new.param_id ,new.param_val ,new.data_type_code ,new.is_active ,new.created_on ,new.dbit_flag ,new.last_updated_at );
END IF;
END IF;

UPDATE oj_b_cache_dbit_maps SET last_updated_at = NOW() WHERE dbit_map_id ='model_explainer_cnfg_prms'; 
End$$ 
DELIMITER ;

DELIMITER $$
create trigger model_explainer_config_paramd before delete on model_explainer_config_params for each row 
 begin 
 Declare v_rec_no bigint; 
Declare is_null CHAR(1);
 Set v_rec_no = OLD.rec_no; 
IF v_rec_no IS NULL THEN
SET  is_null = 'Y';
END IF;
call gen_rec_no('D','model_explainer_config_params',v_rec_no); 
IF is_null = 'Y' THEN
insert into model_explainer_config_paramh (action_no ,sr_no ,model_code ,explainer_id ,param_id ,param_val ,data_type_code ,is_active ,created_on ,dbit_flag ,last_updated_at ) values(v_rec_no  ,old.sr_no ,old.model_code ,old.explainer_id ,old.param_id ,old.param_val ,old.data_type_code ,old.is_active ,old.created_on ,old.dbit_flag ,old.last_updated_at );
update central_log set rec_no = v_rec_no where action_no = v_rec_no;
END IF;

INSERT INTO oj_cdel_rec_info (table_name,rec_no,del_rec_srno) VALUES ('model_explainer_config_params',old.rec_no, old.sr_no);
End$$ 
DELIMITER ;

COMMIT WORK;