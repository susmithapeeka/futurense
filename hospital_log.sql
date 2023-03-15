use python_project1;

SET @@local.net_read_timeout=360;

select * from government_hospitals;
select * from hospitals;

desc government_hospitals;



drop table hospital_log;
CREATE TABLE IF NOT EXISTS hospital_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    state_name VARCHAR(50) NOT NULL,
    area_type VARCHAR(10) NOT NULL,
    action_type ENUM('Added', 'Removed') NOT NULL,
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_government ENUM('No', 'Yes') NOT NULL
);

drop trigger hospital_trigger;

DELIMITER //
CREATE TRIGGER hospital_trigger
AFTER UPDATE ON government_hospitals
    FOR EACH ROW
BEGIN
IF NEW.Rural_Government_Hospitals != OLD.Rural_Government_Hospitals AND NEW.Rural_Government_Hospitals > OLD.Rural_Government_Hospitals THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Rural','Added','Yes');
END IF;
IF NEW.Rural_Government_Hospitals != OLD.Rural_Government_Hospitals AND NEW.Rural_Government_Hospitals < OLD.Rural_Government_Hospitals THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Rural','Removed','Yes');
END IF;
IF NEW.Urban_Government_Hospitals != OLD.Urban_Government_Hospitals AND NEW.Urban_Government_Hospitals > OLD.Urban_Government_Hospitals THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Urban','Added','Yes');
END IF;
IF NEW.Urban_Government_Hospitals != OLD.Urban_Government_Hospitals AND NEW.Urban_Government_Hospitals < OLD.Urban_Government_Hospitals THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Urban','Removed','Yes');
END IF;
END //
delimiter ;

select * from government_hospitals;

update government_hospitals set Rural_Government_Hospitals=Rural_Government_Hospitals+1 where Sno=33; 
update government_hospitals set Urban_Government_Hospitals=Urban_Government_Hospitals+1 where Sno=33; 
select * from government_hospitals;
update government_hospitals set Urban_Government_Hospitals=Urban_Government_Hospitals-1 where Sno=33; 
select * from hospital_log;



select * from hospitals;


#PHC #CHC rural
#Sub district or divisional hospitals
#district hospitals
select * from hospitals;

DELIMITER //
CREATE TRIGGER hospital_trigger2
AFTER UPDATE ON hospitals
    FOR EACH ROW
BEGIN
IF (NEW.Number_of_Primary_Health_Centers != OLD.Number_of_Primary_Health_Centers or NEW.Community_Health_Centers != OLD.Community_Health_Centers ) AND (NEW.Community_Health_Centers > OLD.Community_Health_Centers or NEW.Number_of_Primary_Health_Centers > OLD.Number_of_Primary_Health_Centers )THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Rural','Added','Yes');
END IF;
IF (NEW.Number_of_Primary_Health_Centers != OLD.Number_of_Primary_Health_Centers or NEW.Community_Health_Centers != OLD.Community_Health_Centers ) AND (NEW.Community_Health_Centers < OLD.Community_Health_Centers or NEW.Number_of_Primary_Health_Centers < OLD.Number_of_Primary_Health_Centers )THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Rural','Removed','Yes');
END IF;

IF (NEW.Sub_DistrictorDivisional_Hospitals != OLD.Sub_DistrictorDivisional_Hospitals or NEW.District_Hospitals != OLD.District_Hospitals ) AND (NEW.Sub_DistrictorDivisional_Hospitals > OLD.Sub_DistrictorDivisional_Hospitals or NEW.District_Hospitals > OLD.District_Hospitals )THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Urban','Added','Yes');
END IF;

IF (NEW.Sub_DistrictorDivisional_Hospitals != OLD.Sub_DistrictorDivisional_Hospitals or NEW.District_Hospitals != OLD.District_Hospitals ) AND (NEW.Sub_DistrictorDivisional_Hospitals < OLD.Sub_DistrictorDivisional_Hospitals or NEW.District_Hospitals < OLD.District_Hospitals )THEN
    INSERT INTO hospital_log (state_name,
    area_type,
    action_type ,
    is_government)
    VALUES (old.StateorUT,'Urban','Removed','Yes');
END IF;

END //
delimiter ;

select * from hospitals;
update hospitals set Number_of_Primary_Health_Centers = Number_of_Primary_Health_Centers+1 where sno=1;
select * from hospital_log;


