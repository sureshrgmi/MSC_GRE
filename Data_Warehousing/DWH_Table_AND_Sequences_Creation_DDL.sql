--------------------------------------------------------------------------------
----------------------------- dwh_council_d ------------------------------------
--------------------------------------------------------------------------------

--- Drop Table dwh_council_d
DROP TABLE dwh_council_d;

--- Create Table dwh_council_d
CREATE TABLE dwh_council_d (
    row_wid                        NUMBER(6, 0) PRIMARY KEY,
    localcouncil_id                NUMBER(6, 0),
    localcouncil_name              VARCHAR(30),
    address_line_1                 VARCHAR(30),
    address_line_2                 VARCHAR(30),
    town                           VARCHAR(30),
    county                         VARCHAR(30),
    postcode                       VARCHAR(30),
    telephone_number               VARCHAR(30),
    fax_number                     VARCHAR(30),
    bypass_telephone_number        VARCHAR(30),
    approximate_list_size          NUMBER(6, 0),
    type_of_computer_system        VARCHAR(30),
    computer_used_in_consultations VARCHAR(30),
    appointment_system             NUMBER(6, 0),
    leaflets                       NUMBER(6, 0),
    date_of_last_update            DATE,
    typeoflocalcouncil             NUMBER(6, 0),
    employee_id                    NUMBER(6, 0) UNIQUE,
    employee_title                 VARCHAR(30),
    employee_first_name            VARCHAR(30),
    employee_last_name             VARCHAR(30),
    employee_status                VARCHAR(30),
    yearqualified                  NUMBER(6, 0)
);

--------------------------------------------------------------------------------
--------------------------- dwh_temp_info_d ------------------------------------
--------------------------------------------------------------------------------

--- Drop Table dwh_temp_info_d
DROP TABLE dwh_temp_info_d;

--- Create Table dwh_temp_info_d

CREATE TABLE dwh_temp_info_d (
    row_wid                        NUMBER(6, 0) PRIMARY KEY,
    temp_id                        NUMBER(10, 0),
    temp_title                     VARCHAR(30),
    temp_first_name                VARCHAR(30),
    temp_last_name                 VARCHAR(30),
    temp_address_line_1            VARCHAR(40),
    temp_address_line_2            VARCHAR(40),
    temp_town                      VARCHAR(30),
    temp_county                    VARCHAR(30),
    temp_postcode                  VARCHAR(30),
    temp_tel_home                  VARCHAR(30),
    temp_fax_home                  VARCHAR(30),
    temp_tel_work                  VARCHAR(30),
    temp_fax_work                  VARCHAR(30),
    temp_mobile_phone              VARCHAR(30),
    temp_date_application_was_sent DATE,
    temp_gender                    VARCHAR(30),
    temp_current_status            VARCHAR(30),
    temp_date_of_birth             VARCHAR(30),
    temp_nationality               VARCHAR(30),
    temp_use_of_a_car              VARCHAR(30),
    temp_qualification_year        NUMBER(6, 0),
    temp_qualification_place       VARCHAR(30),
    temp_type_of_cover_preferred   VARCHAR(30),
    temp_shift_monday_am           VARCHAR(30),
    temp_shift_monday_pm           VARCHAR(30),
    temp_shift_tuesday_am          VARCHAR(30),
    temp_shift_tuesday_pm          VARCHAR(30),
    temp_shift_wednesday_am        VARCHAR(30),
    temp_shift_wednesday_pm        VARCHAR(30),
    temp_shift_thursday_am         VARCHAR(30),
    temp_shift_thursday_pm         VARCHAR(30),
    temp_shift_friday_am           VARCHAR(30),
    temp_shift_friday_pm           VARCHAR(30),
    temp_shift_saturday_am         VARCHAR(30),
    temp_registration_status       VARCHAR(30),
    temp_date_application_received DATE,
    temp_status                    VARCHAR(30)
);

--------------------------------------------------------------------------------
---------------------------- dwh_type_of_cover ---------------------------------
--------------------------------------------------------------------------------

--- Drop Table dwh_type_of_cover
DROP TABLE dwh_type_of_cover;

--- Create Table dwh_type_of_cover

CREATE TABLE dwh_type_of_cover (
    row_wid           NUMBER(6, 0) PRIMARY KEY,
    cover_id          NUMBER(6, 0),
    cover_description VARCHAR(30)
);

--------------------------------------------------------------------------------
----------------------------- dwh_mcal_day_d -----------------------------------
--------------------------------------------------------------------------------

--- Drop Table dwh_mcal_day_d
DROP TABLE dwh_mcal_day_d;

--- Create Table dwh_mcal_day_d

CREATE TABLE dwh_mcal_day_d (
    row_wid           NUMBER(15, 0) PRIMARY KEY,
    dt_wid            NUMBER(10, 0),
    day_dt            DATE,
    day               NUMBER(10, 0),
    day_name          VARCHAR(10),
    day_of_the_year   NUMBER(10, 0),
    week_of_the_month NUMBER(10, 0),
    week_of_the_year  NUMBER(10, 0),
    weekname          VARCHAR(10),
    isweekend         NUMBER(10, 0),
    month             NUMBER(10, 0),
    month_name        VARCHAR(10),
    quater            NUMBER(10, 0),
    quater_name       VARCHAR(10),
    qtr_start_dt      DATE,
    qtr_end_dt        DATE,
    year              NUMBER(10, 0),
    year_start_dt     DATE,
    year_end_dt       DATE
);

--------------------------------------------------------------------------------
--------------------- dwh_sess_tempreq_dy_f ------------------------------------
--------------------------------------------------------------------------------

--- Drop Table dwh_sess_tempreq_dy_f
DROP TABLE dwh_sess_tempreq_dy_f;

--- Create Table dwh_sess_tempreq_dy_f
CREATE TABLE dwh_sess_tempreq_dy_f (
    row_wid                     NUMBER(10, 0) PRIMARY KEY,
    sess_id                     NUMBER(15, 0) NOT NULL UNIQUE,
    req_id                      NUMBER(15, 0) NOT NULL,
    cncil_wid                   NUMBER(10, 0) NOT NULL,
    temp_inf_wid                NUMBER(10, 0) NOT NULL,
    session_dt_wid              NUMBER(15, 0),
    session_dt                  DATE,
    session_start_time          VARCHAR(30),
    session_end_time            VARCHAR(30),
    temp_req_shift_monday_am    VARCHAR(30),
    temp_req_shift_monday_pm    VARCHAR(30),
    temp_req_shift_tuesday_am   VARCHAR(30),
    temp_req_shift_tuesday_pm   VARCHAR(30),
    temp_req_shift_wednesday_am VARCHAR(30),
    temp_req_shift_wednesday_pm VARCHAR(30),
    temp_req_shift_thursday_am  VARCHAR(30),
    temp_req_shift_thursday_pm  VARCHAR(30),
    temp_req_shift_friday_am    VARCHAR(30),
    temp_req_shift_friday_pm    VARCHAR(30),
    temp_req_shift_saturday_am  VARCHAR(30),
    status                      VARCHAR(30),
    type_of_cover_wid           NUMBER(15, 0) NOT NULL,
    req_date                    DATE,
    req_start_date              DATE,
    req_end_date                DATE,
    req_num_week                NUMBER(6, 0),
    req_comments                VARCHAR(100),
    CONSTRAINT council_fk FOREIGN KEY ( cncil_wid )
        REFERENCES dwh_council_d ( row_wid ),
    CONSTRAINT temp_inf_fk FOREIGN KEY ( temp_inf_wid )
        REFERENCES dwh_temp_info_d ( row_wid ),
    CONSTRAINT type_of_cover_fk FOREIGN KEY ( type_of_cover_wid )
        REFERENCES dwh_type_of_cover ( row_wid ),
    CONSTRAINT session_dt_fk FOREIGN KEY ( session_dt_wid )
        REFERENCES dwh_mcal_day_d ( row_wid )
);

--------------------------------------------------------------------------------
--------------------- DWH_COUNCIL_EMP_D ------------------------------------
--------------------------------------------------------------------------------

--- Drop Table DWH_COUNCIL_EMP_D
DROP TABLE DWH_COUNCIL_EMP_D;

--- Create Table DWH_COUNCIL_EMP_D

CREATE TABLE "DWH_COUNCIL_EMP_D" (
    "ROW_WID"             NUMBER(6, 0) PRIMARY KEY,
    "LOCALCOUNCIL_ID"     NUMBER(6, 0),
    "EMPLOYEE_ID"         NUMBER(6, 0),
    "EMPLOYEE_TITLE"      VARCHAR2(30 BYTE),
    "EMPLOYEE_FIRST_NAME" VARCHAR2(30 BYTE),
    "EMPLOYEE_LAST_NAME"  VARCHAR2(30 BYTE),
    "EMPLOYEE_STATUS"     VARCHAR2(30 BYTE),
    "YEARQUALIFIED"       NUMBER(6, 0)
);

--------------------------------------------------------------------------------
---------------------- dwh_temp_reference_d ------------------------------------
--------------------------------------------------------------------------------

--- Drop Table DWH_COUNCIL_EMP_D
DROP TABLE dwh_temp_reference_d;

--- Create Table dwh_temp_reference_d
CREATE TABLE dwh_temp_reference_d (
    "ROW_WID"                 NUMBER(10, 0) PRIMARY KEY,
    "TEMP_ID"                 NUMBER(10, 0),
    "REFERENCEID"             NUMBER(10, 0),
    "REFEREEID"               NUMBER(10, 0),
    "DATE_REFERENCE_SENT"     DATE,
    "DATE_REFERENCE_RECEIVED" DATE,
    "TELEPHONE_MADE"          VARCHAR2(30 BYTE),
    "REF_FIRST_NAME"          VARCHAR2(30 BYTE),
    "REF_LAST_NAME"           VARCHAR2(30 BYTE),
    "REF_ADDRESS_LINE_1"      VARCHAR2(60 BYTE),
    "REF_ADDRESS_LINE_2"      VARCHAR2(60 BYTE),
    "REF_TOWN"                VARCHAR2(30 BYTE),
    "REF_COUNTY"              VARCHAR2(30 BYTE),
    "REF_POSTCODE"            VARCHAR2(30 BYTE),
    "REF_TELEPHONE_NUMBER"    VARCHAR2(30 BYTE)
);

--------------------------------------------------------------------------------
-------------------------- sess_tempreq_dy_f_seq -------------------------------
--------------------------------------------------------------------------------

--- Drop Sequence sess_tempreq_dy_f_seq
DROP SEQUENCE sess_tempreq_dy_f_seq;

--- Create Sequence sess_tempreq_dy_f_seq

CREATE SEQUENCE sess_tempreq_dy_f_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1 CACHE 20;

--------------------------------------------------------------------------------
-------------------------- COUNCIL_EMP_D_SEQ -------------------------------
--------------------------------------------------------------------------------

--- Drop Sequence COUNCIL_EMP_D_SEQ
DROP SEQUENCE council_emp_d_seq;

--- Create Sequence COUNCIL_EMP_D_SEQ

CREATE SEQUENCE council_emp_d_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1 CACHE 20;

--------------------------------------------------------------------------------
-------------------------- DW_TIME_SEQ -------------------------------
--------------------------------------------------------------------------------

--- Drop Sequence DW_TIME_SEQ
DROP SEQUENCE dw_time_seq;

--- Create Sequence DW_TIME_SEQ

CREATE SEQUENCE dw_time_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1 CACHE 20;

--------------------------------------------------------------------------------
-------------------------- DWH_COUNCIL_D_SEQ -------------------------------
--------------------------------------------------------------------------------

--- Drop Sequence DWH_COUNCIL_D_SEQ
DROP SEQUENCE dwh_council_d_seq;

--- Create Sequence DWH_COUNCIL_D_SEQ

CREATE SEQUENCE dwh_council_d_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1 CACHE 20;

--------------------------------------------------------------------------------
-------------------------- DWH_SHIFT_D_SEQ -------------------------------
--------------------------------------------------------------------------------

--- Drop Sequence DWH_SHIFT_D_SEQ
DROP SEQUENCE dwh_shift_d_seq;

--- Create Sequence DWH_SHIFT_D_SEQ

CREATE SEQUENCE dwh_shift_d_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1 CACHE 20;

--------------------------------------------------------------------------------
-------------------------- DWH_TEMP_INFO_D_SEQ -------------------------------
--------------------------------------------------------------------------------

--- Drop Sequence DWH_TEMP_INFO_D_SEQ
DROP SEQUENCE dwh_temp_info_d_seq;

--- Create Sequence DWH_TEMP_INFO_D_SEQ

CREATE SEQUENCE dwh_temp_info_d_seq MINVALUE 1 MAXVALUE 999999999 START WITH 1 INCREMENT BY 1 CACHE 20;