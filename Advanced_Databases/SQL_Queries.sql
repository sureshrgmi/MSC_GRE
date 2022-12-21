-- Creating Tablespace

CREATE TABLESPACE tbs_extra
DATAFILE '/u01/app/oracle/oradata/SR0902M/tbs_extra01.dbf'
SIZE 3G
AUTOEXTEND ON NEXT 1G
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO
ONLINE;


-- Password Verification Function

CREATE OR REPLACE FUNCTION
my_pw_verification (
username VARCHAR2,
password VARCHAR2,
old_password VARCHAR2)
RETURN BOOLEAN AS
BEGIN
    IF LENGTH(password) < 6 THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END my_pw_verification;


-- Creating Department Profile

CREATE PROFILE department_profile
LIMIT
IDLE_TIME 45
PASSWORD_REUSE_MAX UNLIMITED
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME 5/4
PASSWORD_LIFE_TIME 60
PASSWORD_VERIFY_FUNCTION my_pw_verification;


-- Creating Cust_Service user

CREATE USER cust_service
IDENTIFIED BY cust_serv213
PROFILE department_profile
DEFAULT TABLESPACE tbs_extra
QUOTA UNLIMITED ON tbs_extra
TEMPORARY TABLESPACE temp
PASSWORD EXPIRE;

-- Creating Inv user

CREATE USER inv
IDENTIFIED BY inv213
PROFILE department_profile
DEFAULT TABLESPACE tbs_extra
QUOTA UNLIMITED ON tbs_extra
TEMPORARY TABLESPACE temp
PASSWORD EXPIRE;

-- Creating role CUST_SERVICE_ROLE

CREATE ROLE CUST_SERVICE_ROLE;

-- Granting privileges to CUST_SERVICE_ROLE

GRANT CREATE SESSION TO CUST_SERVICE_ROLE;
GRANT SELECT ON OE.ORDERS TO CUST_SERVICE_ROLE;
GRANT SELECT ON OE.ORDER_ITEMS TO CUST_SERVICE_ROLE;
GRANT SELECT ON OE.PRODUCT_INFORMATION TO CUST_SERVICE_ROLE;
GRANT SELECT ON OE.PRODUCT_DESCRIPTIONS TO CUST_SERVICE_ROLE;

-- Granting CUST_SERVICE_TOLE to Cust_Service user

GRANT CUST_SERVICE_ROLE TO CUST_SERVICE;

-- Creating role INVENTORY_ROLE

CREATE ROLE INVENTORY_ROLE;

-- Granting privileges to INVENTORY_ROLE

GRANT CREATE SESSION TO INVENTORY_ROLE;
GRANT CREATE TABLE TO INVENTORY_ROLE;
GRANT CREATE VIEW TO INVENTORY_ROLE;
GRANT SELECT, INSERT, UPDATE ON OE.PRODUCT_INFORMATION TO INVENTORY_ROLE;
GRANT SELECT, INSERT, UPDATE ON OE.PRODUCT_DESCRIPTIONS TO INVENTORY_ROLE;
GRANT SELECT, INSERT, UPDATE ON OE.INVENTORIES TO INVENTORY_ROLE;

-- Granting INVENTORY_ROLE to Inv user

GRANT INVENTORY_ROLE TO INV;

