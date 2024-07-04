--2. Compra promedio en litros por cliente en el tiempo
CREATE VIEW consulta2 AS
SELECT 
    fact.Key_Customer,
    AVG(Cantidad_litros) AS Promedio_Litros_Consumidos,
    t.a�o,
    t.mes
FROM 
    datawarehouse.dbo.Fact_Sales_G15 fact
JOIN datawarehouse.dbo.Time_G15 t 
    ON fact.DATE = t.Key_Fecha

GROUP BY 
	Key_Customer,
    a�o,
	mes