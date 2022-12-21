-- Script to craete the Function FUNCT_CHECK_CUSTOMER

CREATE OR REPLACE EDITIONABLE FUNCTION "OE"."FUNCT_CHECK_CUSTOMER" (
    p_order_id IN orders.order_id%TYPE
) RETURN CHAR IS

    cust_type VARCHAR(30);
    cust_id   customers.customer_id%TYPE;
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
        RETURN ( 'Invalid Order ID' );
    ELSE
        SELECT
            CASE
            WHEN COUNT(o.order_id) > 1 THEN
            'REPEATED CUSTOMER'
            ELSE
            'ONE-TIME CUSTOMER'
            END AS cust_type
        INTO cust_type
        FROM
            oe.customers c,
            oe.orders    o
        WHERE
            c.customer_id = o.customer_id
            AND c.customer_id = cust_id
        GROUP BY
            c.customer_id;

        RETURN cust_type;
    END IF;

    CLOSE cust_id_cursor;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(sqlerrm);
END;

/



-- SQL Query using the Function

SELECT
o.order_id AS "Order ID",
c.customer_id AS "Customer ID",
concat(
concat(
c.cust_first_name, ' '
), c.cust_last_name
) AS "Full Name",
funct_check_customer(
o.order_id
) AS "Customer Type"
FROM
orders o
JOIN customers c ON o.customer_id = c.customer_id;