--14. Se desea saber tambien si las bebidas en lata est�n bajando su consumoCREATE VIEW consulta14 asSELECT t.A�o, SUM(fa.QUANTITY) CantidadProductos
from Fact_Sales_G15 fa
join Time_G15 t on t.Key_Fecha = fa.DATE
join Product_G15 p on p.Key_Product = fa.Key_Product
WHERE p.Unidad LIKE 'cm3%'
group by t.A�o
--order by CantidadProductos asc