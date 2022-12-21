--------------------------- dwh_type_of_cover ----------------------------------

INSERT INTO dwh_type_of_cover (
    row_wid,
    cover_id,
    cover_description
)
    SELECT
        dwh_temp_info_d_seq.NEXTVAL AS row_wid,
        totc."TypeofCoverID"        AS cover_id,
        totc."CoverDescription"
    FROM
        type_of_temp_cover totc;
    
------------------- dwh_temp_info_d --------------------------------------------

INSERT INTO dwh_temp_info_d (
    row_wid,
    temp_id,
    temp_title,
    temp_first_name,
    temp_last_name,
    temp_address_line_1,
    temp_address_line_2,
    temp_town,
    temp_county,
    temp_postcode,
    temp_tel_home,
    temp_fax_home,
    temp_tel_work,
    temp_fax_work,
    temp_mobile_phone,
    temp_date_application_was_sent,
    temp_gender,
    temp_current_status,
    temp_date_of_birth,
    temp_nationality,
    temp_use_of_a_car,
    temp_qualification_year,
    temp_qualification_place,
    temp_type_of_cover_preferred,
    temp_shift_monday_am,
    temp_shift_monday_pm,
    temp_shift_tuesday_am,
    temp_shift_tuesday_pm,
    temp_shift_wednesday_am,
    temp_shift_wednesday_pm,
    temp_shift_thursday_am,
    temp_shift_thursday_pm,
    temp_shift_friday_am,
    temp_shift_friday_pm,
    temp_shift_saturday_am,
    temp_registration_status,
    temp_date_application_received,
    temp_status
)
    (
        SELECT
            dwh_temp_info_d_seq.NEXTVAL                                 AS row_wid,
            CAST(temp."TempID" AS NUMBER)                               AS temp_id,
            emp_t."TitleDescription"                                    AS temp_title,
            temp."First Name"                                           AS temp_first_name,
            temp."Last Name"                                            AS temp_last_name,
            temp."Address Line 4"                                       AS temp_address_line_1,
            temp."Address Line 2"                                       AS temp_address_line_2,
            temp."Town"                                                 AS temp_town,
            temp."County"                                               AS temp_county,
            temp."Postcode"                                             AS temp_postcode,
            temp."Tel#6ome"                                             AS temp_tel_home,
            temp."Fax#Home"                                             AS temp_fax_home,
            temp."Tel#Work"                                             AS temp_tel_work,
            temp."Fax#Work"                                             AS temp_fax_work,
            temp."Mobile Phone#"                                        AS temp_mobile_phone,
            to_char(temp."Date application was sent", 'DD-MON-YY')      AS temp_date_application_was_sent,
            tempgender."GenderDescription"                              AS temp_gender,
            tempcurrentstatus."CurrentStatusDescription"                AS temp_current_status,
            temp."Date of birth"                                        AS temp_date_of_birth,
            nationality."NationalityDescription"                        AS temp_nationality,
            CASE
                WHEN temp."Use of a car" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_use_of_a_car,
            temp."Qualification Year"                                   AS temp_qualification_year,
            temp."Qualification Place"                                  AS temp_qualification_place,
            totc."CoverDescription"                                     AS temp_type_of_cover_preferred,
            CASE
                WHEN temp."Monday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_monday_am,
            CASE
                WHEN temp."Monday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_monday_pm,
            CASE
                WHEN temp."Tuesday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_tuesday_am,
            CASE
                WHEN temp."Tuesday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_tuesday_pm,
            CASE
                WHEN temp."Wednesday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_wednesday_am,
            CASE
                WHEN temp."Wednesday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_wednesday_pm,
            CASE
                WHEN temp."Thursday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_thursday_am,
            CASE
                WHEN temp."Thursday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_thursday_pm,
            CASE
                WHEN temp."Friday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_friday_am,
            CASE
                WHEN temp."Friday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_friday_pm,
            CASE
                WHEN temp."Saturday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_saturday_am,
            tempregistrationstatus."LocumRegistrationStatusDescription" AS temp_registration_status,
            to_char(TO_DATE(temp."Date application received", 'DD/MM/YY'),
                    'DD-MON-YY')                                        AS temp_date_application_received,
            tempstatus."TempStatusDescription"                          AS temp_status
        FROM
                 "TEMP" temp
            JOIN "TEMP_NATIONALITY"       nationality ON ( temp."Nationality" = nationality."NationalityID" )
            JOIN "TYPE_OF_TEMP_COVER"     totc ON ( temp."Type of Cover Preferred" = totc."TypeofCoverID" )
            JOIN "TempStatus"             tempstatus ON ( temp."TempStatus" = tempstatus."TempStatusID" )
            JOIN "EMPLOYEE_TITLE"         emp_t ON ( temp."Title" = emp_t."TitleID" )
            JOIN "TempGender"             tempgender ON ( temp."Gender" = tempgender."GenderID" )
            JOIN "TempRegistrationStatus" tempregistrationstatus ON ( temp."Temp Registration Status" = tempregistrationstatus."LocumRegistrationStatusID"
            )
            JOIN "TempCurrent Status"     tempcurrentstatus ON ( temp."Current Status" = tempcurrentstatus."CurrentStatusID" )
    );
 
 
------------------------------ dwh_council_d -----------------------------------

INSERT INTO dwh_council_d (
    row_wid,
    localcouncil_id,
    localcouncil_name,
    address_line_1,
    address_line_2,
    town,
    county,
    postcode,
    telephone_number,
    fax_number,
    bypass_telephone_number,
    approximate_list_size,
    type_of_computer_system,
    computer_used_in_consultations,
    appointment_system,
    leaflets,
    date_of_last_update,
    typeoflocalcouncil
)
    SELECT
        dwh_council_d_seq.NEXTVAL,
        lc."LocalCouncil_ID"                AS localcouncil_id,
        lc."LocalCouncilName"               AS localcouncil_name,
        lc."Address Line 1"                 AS address_line_1,
        lc."Address Line 2"                 AS address_line_2,
        lc."Town"                           AS town,
        lc."County"                         AS county,
        lc."Postcode"                       AS postcode,
        lc."Telephone#"                     AS telephone_number,
        lc."Fax#"                           AS fax_number,
        lc."Bypass#"                        AS bypass_telephone_number,
        lc."Approximate List Size"          AS approximate_list_size,
        ccs."ComputerSystemDescription"     AS type_of_computer_system,
        lc."Computer Used in Consultations" AS computer_used_in_consultations,
        lc."Appointment System"             AS appointment_system,
        lc."Leaflets"                       AS leaflets,
        lc."Date of Last Update"            AS date_of_last_update,
        lc."TypeofLocalCouncil"             AS typeoflocalcouncil
    FROM
             local_council lc
        JOIN careprovider_computer_system ccs ON ( lc."Type of Computer System" = ccs."ComputerSystemID" );
        
--------------------------- dwh_council_emp_d ----------------------------------
INSERT INTO dwh_council_emp_d (
    row_wid,
    localcouncil_id,
    employee_id,
    employee_title,
    employee_first_name,
    employee_last_name,
    employee_status,
    yearqualified
)
    (
        SELECT
            council_emp_d_seq.NEXTVAL AS row_wid,
            emp_d."LocalCouncil_ID",
            emp_d."Employee_ID"       AS employee_id,
            emp_t."TitleDescription"  AS employee_title,
            emp_d."First Name"        AS employee_first_name,
            emp_d."Last Name"         AS employee_last_name,
            emp_d."Status"            AS employee_status,
            emp_d."YearQualified"     AS yearqualified
        FROM
            employee_details emp_d,
            employee_title   emp_t
        WHERE
            emp_d."Title" = emp_t."TitleID"
    );
    
------------------------------ dwh_temp_info_d ---------------------------------   

INSERT INTO dwh_temp_info_d (
    row_wid,
    temp_id,
    temp_title,
    temp_first_name,
    temp_last_name,
    temp_address_line_1,
    temp_address_line_2,
    temp_town,
    temp_county,
    temp_postcode,
    temp_tel_home,
    temp_fax_home,
    temp_tel_work,
    temp_fax_work,
    temp_mobile_phone,
    temp_date_application_was_sent,
    temp_gender,
    temp_current_status,
    temp_date_of_birth,
    temp_nationality,
    temp_use_of_a_car,
    temp_qualification_year,
    temp_qualification_place,
    temp_type_of_cover_preferred,
    temp_shift_monday_am,
    temp_shift_monday_pm,
    temp_shift_tuesday_am,
    temp_shift_tuesday_pm,
    temp_shift_wednesday_am,
    temp_shift_wednesday_pm,
    temp_shift_thursday_am,
    temp_shift_thursday_pm,
    temp_shift_friday_am,
    temp_shift_friday_pm,
    temp_shift_saturday_am,
    temp_registration_status,
    temp_date_application_received,
    temp_status
)
    (
        SELECT
            dwh_temp_info_d_seq.NEXTVAL                                 AS row_wid,
            CAST(temp."TempID" AS NUMBER)                               AS temp_id,
            emp_t."TitleDescription"                                    AS temp_title,
            temp."First Name"                                           AS temp_first_name,
            temp."Last Name"                                            AS temp_last_name,
            temp."Address Line 4"                                       AS temp_address_line_1,
            temp."Address Line 2"                                       AS temp_address_line_2,
            temp."Town"                                                 AS temp_town,
            temp."County"                                               AS temp_county,
            temp."Postcode"                                             AS temp_postcode,
            temp."Tel#6ome"                                             AS temp_tel_home,
            temp."Fax#Home"                                             AS temp_fax_home,
            temp."Tel#Work"                                             AS temp_tel_work,
            temp."Fax#Work"                                             AS temp_fax_work,
            temp."Mobile Phone#"                                        AS temp_mobile_phone,
            to_char(temp."Date application was sent", 'DD-MON-YY')      AS temp_date_application_was_sent,
            tempgender."GenderDescription"                              AS temp_gender,
            tempcurrentstatus."CurrentStatusDescription"                AS temp_current_status,
            temp."Date of birth"                                        AS temp_date_of_birth,
            nationality."NationalityDescription"                        AS temp_nationality,
            CASE
                WHEN temp."Use of a car" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_use_of_a_car,
            temp."Qualification Year"                                   AS temp_qualification_year,
            temp."Qualification Place"                                  AS temp_qualification_place,
            totc."CoverDescription"                                     AS temp_type_of_cover_preferred,
            CASE
                WHEN temp."Monday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_monday_am,
            CASE
                WHEN temp."Monday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_monday_pm,
            CASE
                WHEN temp."Tuesday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_tuesday_am,
            CASE
                WHEN temp."Tuesday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_tuesday_pm,
            CASE
                WHEN temp."Wednesday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_wednesday_am,
            CASE
                WHEN temp."Wednesday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_wednesday_pm,
            CASE
                WHEN temp."Thursday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_thursday_am,
            CASE
                WHEN temp."Thursday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_thursday_pm,
            CASE
                WHEN temp."Friday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_friday_am,
            CASE
                WHEN temp."Friday PM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_friday_pm,
            CASE
                WHEN temp."Saturday AM" = 0 THEN
                    'YES'
                ELSE
                    'NO'
            END                                                         AS temp_shift_saturday_am,
            tempregistrationstatus."LocumRegistrationStatusDescription" AS temp_registration_status,
            to_char(TO_DATE(temp."Date application received", 'DD/MM/YY'),
                    'DD-MON-YY')                                        AS temp_date_application_received,
            tempstatus."TempStatusDescription"                          AS temp_status
        FROM
                 "TEMP" temp
            JOIN "TEMP_NATIONALITY"       nationality ON ( temp."Nationality" = nationality."NationalityID" )
            JOIN "TYPE_OF_TEMP_COVER"     totc ON ( temp."Type of Cover Preferred" = totc."TypeofCoverID" )
            JOIN "TempStatus"             tempstatus ON ( temp."TempStatus" = tempstatus."TempStatusID" )
            JOIN "EMPLOYEE_TITLE"         emp_t ON ( temp."Title" = emp_t."TitleID" )
            JOIN "TempGender"             tempgender ON ( temp."Gender" = tempgender."GenderID" )
            JOIN "TempRegistrationStatus" tempregistrationstatus ON ( temp."Temp Registration Status" = tempregistrationstatus."LocumRegistrationStatusID"
            )
            JOIN "TempCurrent Status"     tempcurrentstatus ON ( temp."Current Status" = tempcurrentstatus."CurrentStatusID" )
    );


----------------------- dwh_temp_reference_d -----------------------------------

INSERT INTO dwh_temp_reference_d (
    row_wid,
    temp_id,
    referenceid,
    refereeid,
    date_reference_sent,
    date_reference_received,
    telephone_made,
    ref_first_name,
    ref_last_name,
    ref_address_line_1,
    ref_address_line_2,
    ref_town,
    ref_county,
    ref_postcode,
    ref_telephone_number
)
    (
        SELECT
            dwh_temp_info_d_seq.NEXTVAL   AS row_wid,
            CAST(temp."TempID" AS NUMBER) AS temp_id,
            references."ReferenceID"      AS referenceid,
            references."RefereeID"        AS refereeid,
            to_char(TO_DATE(references."Date Reference Sent", 'DD/MM/YY'),
                    'DD-MON-YY')          AS date_reference_sent,
            to_char(TO_DATE(references."Date Reference Received", 'DD/MM/YY'),
                    'DD-MON-YY')          AS date_reference_received,
            references."Telephone made"   AS telephone_made,
            details."First Name"          AS ref_first_name,
            details."Last Name"           AS ref_last_name,
            details."Address Line 1"      AS ref_address_line_1,
            details."Adress Line 2"       AS ref_address_line_2,
            details."Town"                AS ref_town,
            details."County"              AS ref_county,
            details."Postcode"            AS ref_postcode,
            details."Tel#"                AS ref_telephone_number
        FROM
                 "TEMP" temp
            JOIN "REFERENCES"        references ON ( temp."TempID" = references."TempID" )
            JOIN "REFEREES' DETAILS" details ON ( references."RefereeID" = details."RefereeID" )
    );
    
---------------------- dwh_sess_tempreq_dy_f -----------------------------------

    INSERT INTO dwh_sess_tempreq_dy_f (
        row_wid,
        session_dt,
        session_dt_wid,
        session_start_time,
        session_end_time,
        temp_req_shift_monday_am,
        temp_req_shift_monday_pm,
        temp_req_shift_tuesday_am,
        temp_req_shift_tuesday_pm,
        temp_req_shift_wednesday_am,
        temp_req_shift_wednesday_pm,
        temp_req_shift_thursday_am,
        temp_req_shift_thursday_pm,
        temp_req_shift_friday_am,
        temp_req_shift_friday_pm,
        temp_req_shift_saturday_am,
        status,
        type_of_cover_wid,
        req_date,
        req_start_date,
        req_end_date,
        req_num_week,
        req_comments,
        sess_id,
        req_id,
        cncil_wid,
        temp_inf_wid
    )
        (
            SELECT
                sess_tempreq_dy_f_seq.NEXTVAL AS row_wid,
                sess_tbl."SessionDate"        AS session_dt,
                mcal_d.row_wid                AS session_dt_wid,
                sess_tbl."SessionStart"       AS session_start_time,
                sess_tbl."SessionEnd"         AS session_end_time,
                temp_req."Monday AM"          AS temp_req_shift_monday_am,
                temp_req."Monday PM"          AS temp_req_shift_monday_pm,
                temp_req."Tuesday AM"         AS temp_req_shift_tuesday_am,
                temp_req."Tuesday PM"         AS temp_req_shift_tuesday_pm,
                temp_req."Wednesday AM"       AS temp_req_shift_wednesday_am,
                temp_req."Wednesday PM"       AS temp_req_shift_wednesday_pm,
                temp_req."Thursday AM"        AS temp_req_shift_thursday_am,
                temp_req."Thursday PM"        AS temp_req_shift_thursday_pm,
                temp_req."Friday AM"          AS temp_req_shift_friday_am,
                temp_req."Friday PM"          AS temp_req_shift_friday_pm,
                temp_req."Saturday AM"        AS temp_req_shift_saturday_am,
                sess_tbl."Status"             AS status,
                cover_d.row_wid               AS type_of_cover_wid,
                temp_req."Request date"       AS req_date,
                temp_req."Start date"         AS req_start_date,
                temp_req."End date"           AS req_end_date,
                temp_req."Number of weeks"    AS req_num_week,
                temp_req."Comments"           AS req_comments,
                sess_tbl."SessionID"          AS sess_id,
                temp_req."TempRequestID"      AS req_id,
                council_d.row_wid             AS cncil_wid,
                CASE
                    WHEN temp_info_d.row_wid IS NULL THEN
                        0
                    ELSE
                        temp_info_d.row_wid
                END                           AS temp_inf_wid
            FROM
                dwh_mcal_day_d       mcal_d,
                dwh_temp_info_d      temp_info_d,
                dwh_type_of_cover    cover_d,
                dwh_council_d        council_d,
                "SESSION"            sess_tbl,
                "TEMP_REQUEST"       temp_req,
                "TYPE_OF_TEMP_COVER" src_cover
            WHERE
                    sess_tbl."RequestID" = temp_req."TempRequestID"
                AND temp_req."LocalCouncil_ID" = council_d.localcouncil_id
                AND sess_tbl."SessionDate" = mcal_d.day_dt
                AND temp_info_d.temp_id = sess_tbl."TempID"
                AND cover_d.cover_id = sess_tbl."Type"
                AND src_cover."TypeofCoverID" (+) = cover_d.cover_id
        );