-- Borrar la tabla temporal si existe
DROP TABLE IF EXISTS #PRICE;

-- Crear la tabla temporal con los precios
SELECT
    PRODUCT_ID,
    DATE AS FechaDesde,
    LEAD(DATE) OVER (PARTITION BY PRODUCT_ID ORDER BY DATE) AS FechaHasta,
    PRICE
INTO #PRICE
FROM staging.dbo.stg_prices_G15;

-- Insertar datos en la tabla de hechos
INSERT INTO datawarehouse.dbo.fact_sales_G15 (
    billing_id, sale_date, key_customer, key_employee, key_product, quantity, region, price, Cantidad_litros, key_time
)
SELECT 
    BillingSql.BILLING_ID, 
    BillingSql.date,
    Cus.key_customer, 
    Emp.key_employee, 
    Prod.key_product, 
    BillingSql.QUANTITY, 
    BillingSql.REGION, 
    Prices.PRICE,
    IntProd.cantidad_litros,
    CONVERT(INT, FORMAT(BillingSql.date, 'yyyyMMdd')) AS key_time
FROM intermedia.dbo.int_billing_hist_G15 AS BillingSql
LEFT JOIN #PRICE AS Prices
    ON BillingSql.PRODUCT_ID = Prices.PRODUCT_ID
    AND BillingSql.date >= Prices.FechaDesde
    AND (BillingSql.date < Prices.FechaHasta OR Prices.FechaHasta IS NULL)
LEFT JOIN datawarehouse.dbo.dim_product_G15 AS Prod
    ON BillingSql.PRODUCT_ID = Prod.product_id
LEFT JOIN datawarehouse.dbo.dim_customer_G15 AS Cus
    ON BillingSql.CUSTOMER_ID = Cus.customer_id
LEFT JOIN datawarehouse.dbo.dim_employee_G15 AS Emp
    ON BillingSql.EMPLOYEE_ID = Emp.employee_id
LEFT JOIN intermedia.dbo.int_productos_G15 AS IntProd
    ON BillingSql.PRODUCT_ID = IntProd.id_producto

UNION ALL

SELECT 
    MySql.BILLING_ID, 
    MySql.DATE, 
    Cus.key_customer, 
    Emp.key_employee, 
    Prod.key_product, 
    MySqlDetail.QUANTITY, 
    MySql.REGION, 
    Prices.PRICE,
    IntProd.cantidad_litros,
    CONVERT(INT, FORMAT(MySql.DATE, 'yyyyMMdd')) AS key_time
FROM intermedia.dbo.int_billing_G15 AS MySql
INNER JOIN staging.dbo.stg_billing_detail_G15 AS MySqlDetail
    ON MySql.BILLING_ID = MySqlDetail.BILLING_ID
LEFT JOIN #PRICE AS Prices
    ON MySqlDetail.PRODUCT_ID = Prices.PRODUCT_ID
    AND MySql.DATE >= Prices.FechaDesde
    AND (MySql.DATE < Prices.FechaHasta OR Prices.FechaHasta IS NULL)
LEFT JOIN datawarehouse.dbo.dim_product_G15 AS Prod
    ON MySqlDetail.PRODUCT_ID = Prod.product_id
LEFT JOIN datawarehouse.dbo.dim_customer_G15 AS Cus
    ON MySql.CUSTOMER_ID = Cus.customer_id
LEFT JOIN datawarehouse.dbo.dim_employee_G15 AS Emp
    ON MySql.EMPLOYEE_ID = Emp.employee_id
LEFT JOIN intermedia.dbo.int_productos_G15 AS IntProd
    ON MySqlDetail.PRODUCT_ID = IntProd.id_producto;
