set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "OE"."CHECK_CUSTOMER" (
    p_order_id orders.order_id%TYPE
) AS

    cust_type     VARCHAR(30);
    no_of_order   NUMBER;
    cust_id       customers.customer_id%TYPE;
    first_name    customers.cust_first_name%TYPE;
    last_name     customers.cust_last_name%TYPE;
    email         customers.cust_email%TYPE;
    date_of_birth customers.date_of_birth%TYPE;
    gender        customers.gender%TYPE;
    CURSOR cust_id_cursor IS
    SELECT
        customer_id
    FROM
        oe.orders
    WHERE
        order_id = p_order_id;

BEGIN
    OPEN cust_id_cursor;
    FETCH cust_id_cursor INTO cust_id;
    IF cust_id_cursor%notfound THEN
        dbms_output.put_line('We couldn''t find any records for the order ID provided.');
    ELSE
        SELECT
            c.cust_first_name,
            c.cust_last_name,
            c.cust_email,
            c.date_of_birth,
            c.gender,
            CASE
            WHEN COUNT(o.order_id) > 1 THEN
            'REPEATED CUSTOMER'
            ELSE
            'ONE-TIME CUSTOMER'
            END AS cust_type,
            COUNT(o.order_id)
        INTO
            first_name,
            last_name,
            email,
            date_of_birth,
            gender,
            cust_type,
            no_of_order
        FROM
            oe.customers c,
            oe.orders    o
        WHERE
            c.customer_id = o.customer_id
            AND c.customer_id = cust_id
        GROUP BY
            c.cust_first_name,
            c.cust_last_name,
            c.cust_email,
            c.date_of_birth,
            c.gender;

        -- Printing the results

        dbms_output.put_line('Following is the customer information for the order id:' || p_order_id);
        dbms_output.put_line('Customer ID:' || cust_id);
        dbms_output.put_line('Customer Name:'
                             || first_name
                             || ' '
                             || last_name);
        dbms_output.put_line('Date of Birth:' || date_of_birth);
        dbms_output.put_line('Gender:' || gender);
        dbms_output.put_line('Email:' || lower(email));
        dbms_output.put_line('Customer Type:' || cust_type);
    END IF;

    CLOSE cust_id_cursor;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
END;

/