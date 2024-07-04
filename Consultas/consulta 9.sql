--9. Tambi�n desea saber cu�les ser�n los 5 vendedores m�s prometedores 
--en monto de ventas para el a�o 2011.
CREATE VIEW consulta9 as
SELECT TOP 5
E.key_employee, 
T.a�o,
ROUND(SUM(fact.QUANTITY * fact.Price), 2) AS monto

FROM Fact_Sales_G15 fact
JOIN Employee_G15 AS E
ON E.Key_Employee = fact.Key_Employee
JOIN Time_G15 AS T
ON  T.Key_Fecha = fact.DATE

WHERE T.A�o = 2009

GROUP BY
E.Key_Employee, T.A�o