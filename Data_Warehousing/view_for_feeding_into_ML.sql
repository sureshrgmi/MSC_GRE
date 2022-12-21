--------------------------------------------------------
--  DDL for View DECISION_TREE_VIEW
--------------------------------------------------------

CREATE OR REPLACE FORCE EDITIONABLE VIEW "SR0902M"."DECISION_TREE_VIEW" (
    "SESSION_DATE",
    "QUARTER",
    "APPOINTMENT_SYSTEM",
    "COUNCIL_TYPE",
    "GENDER",
    "AGE_BAND",
    "PREFERRED_COVER",
    "USES_CAR",
    "COVER"
) AS
    WITH src AS (
        SELECT
            day_dt                                              AS session_date,
            quarter,
            appointment_system,
            council_type,
            temp_gender                                         AS gender,
            trunc(months_between(day_dt,
                                 TO_DATE(temp_date_of_birth, 'dd-mm-yyyy')) / 12) AS age,
            preferred_cover,
            uses_car,
            cover
        FROM
            (
                SELECT
                    c.day_dt,
                    c.quater                        AS quarter,
                    cc.appointment_system,
                    cc.typeoflocalcouncil           AS council_type,
                    ti.temp_gender,
                    ti.temp_date_of_birth,
                    ti.temp_type_of_cover_preferred AS preferred_cover,
                    ti.temp_use_of_a_car            AS uses_car,
                    t.cover_description             AS cover
                FROM
                    dwh_mcal_day_d        c
                    LEFT JOIN dwh_sess_tempreq_dy_f s ON s.session_dt_wid = c.row_wid
                    JOIN dwh_type_of_cover     t ON s.type_of_cover_wid = t.row_wid
                    JOIN dwh_temp_info_d       ti ON s.temp_inf_wid = ti.row_wid
                    JOIN dwh_council_d         cc ON s.cncil_wid = cc.row_wid
                ORDER BY
                    day_dt ASC
            ) src1
    )
    SELECT
        src.session_date,
        src.quarter,
        src.appointment_system,
        src.council_type,
        src.gender,
        CASE
            WHEN src.age > 60              THEN
                '>60'
            WHEN src.age BETWEEN 51 AND 60 THEN
                '51-60'
            WHEN src.age BETWEEN 41 AND 50 THEN
                '41-50'
            WHEN src.age BETWEEN 3 AND 40  THEN
                '31-40'
            ELSE
                '<30'
        END AS age_band,
        src.preferred_cover,
        src.uses_car,
        src.cover
    FROM
        src;