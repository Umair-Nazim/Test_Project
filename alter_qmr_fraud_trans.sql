begin work;
SET CONSTRAINTS ALL DEFERRED;

--Add sr_no column as integer
ALTER TABLE qmr_fraud_trans MODIFY (trace_audit_no BIGINT); 
ALTER TABLE qmr_fraud_trans ADD sr_no integer; 

--Create sequence to populate sr_no column with sequential unique values
CREATE SEQUENCE num_seq 
    INCREMENT BY 1 START WITH 1; 

CREATE INDEX mcp.idx_qmr_fraud_trans_sr_no ON mcp.qmr_fraud_trans(sr_no) ONLINE;
 
--Procedure to update sr_no column 1 by 1

CREATE PROCEDURE mcp.pr_sr_no_increment()
	DEFINE num varchar(19);
	DEFINE i INTEGER;
	DEFINE max_count INTEGER;
	LET i = 0;
	LET max_count = (select count(*) from qmr_fraud_trans );
	WHILE i < max_count
		select first 1 trace_audit_no into num from qmr_fraud_trans  where sr_no is null;
		UPDATE qmr_fraud_trans  SET sr_no  = num_seq.NEXTVAL where trace_audit_no = num;
		LET i = i+1;
	END WHILE;
	END PROCEDURE ;

--Execute procedure
EXECUTE PROCEDURE pr_sr_no_increment();

--Revert creare Sequence
DROP SEQUENCE num_seq;

--Revert create procedure
DROP PROCEDURE mcp.pr_sr_no_increment;

--Change sr_no type from int to serial after procedure is executed
ALTER TABLE qmr_fraud_trans MODIFY (sr_no SERIAL NOT NULL); 

--Create index for sr_no
CREATE INDEX mcp.idx_qmr_fraud_trans_sr_no ON mcp.qmr_fraud_trans(sr_no) ONLINE;

UPDATE STATISTICS FOR TABLE qmr_fraud_trans;
commit work;
