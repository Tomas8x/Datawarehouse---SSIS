# Proyecto de Data Warehouse

## Descripción General

Este proyecto consiste en la creación de un Data Warehouse utilizando como fuente de datos distintos tipos de archivos (.txt, .xml, .csv, etc). El objetivo principal es integrar y analizar datos provenientes de múltiples fuentes para generar insights valiosos a través de visualizaciones en Power BI.

## Estructura del Proyecto

### Bases de Datos

Se han creado tres bases de datos distintas en SQL Server:

#### Staging

- Creé una base de datos llamada Staging en SQL Server.
- Conecté la base de datos en Visual Studio 2022 y traje los datos desde todas las fuentes y los cargué tal como estaban en SQL Server.
- Además, me conecté a los dos servidores (MySQL y SQL Server) propuestos por los profesores para obtener más fuentes de datos.

#### Intermedia

- Creé una base de datos llamada Intermedia.
- Utilicé Visual Studio para realizar el proceso de limpieza de datos, similar a un proceso ETL (Extract, Transform, Load).
- En SQL Server, creé un Stored Procedure que crea una tabla llamada `tiempo`, obteniendo la fecha mínima de la tabla `BillingHist` y la fecha máxima de la tabla `Billing`.
- En la tabla `tiempo`, se realiza la conversión de todas las fechas, separándolas en Fecha, Día, Mes, Año, Trimestre, Semestre, etc.

#### DataWarehouse

- Desde Visual Studio realicé la carga de todas las dimensiones y su respectiva tabla de hechos.

### Diagrama de Datos

El diagrama de datos en forma de copo de nieve se puede visualizar perfectamente, permitiendo una clara comprensión de las relaciones entre las diferentes tablas.

![Diagrama Data Warehouse](https://github.com/Tomas8x/Datawarehouse---SSIS/blob/main/media/diagrama.png)

## Herramientas Utilizadas

- **SQL Server**: Para la creación y gestión de las bases de datos.
- **Visual Studio 2022**: Para la limpieza y modificación de datos.
- **Power BI**: Para la creación de visualizaciones y análisis de datos.

## Consultas SQL

Se respondieron ciertas preguntas que se pueden observar en el PDF llamado `TP Final` mediante consultas SQL, las cuales se llevaron a Power BI como vistas para poder graficar y analizar los datos de manera efectiva.

## Visualizaciones en Power BI

Se crearon diversas visualizaciones en Power BI para representar los insights obtenidos del análisis de datos. Aquí puedes ver un ejemplo de las visualizaciones realizadas:

![Dashboard Power BI](ruta_a_la_imagen)

## Cómo Ejecutar el Proyecto

### Configurar Conexiones:

- Asegúrate de poder realizar correctamente las conexiones a los servidores correspondientes. En mi caso, utilicé ODBC Data Source (32-bit).

### Crear Bases de Datos:

- Crear las bases de datos Staging, Intermedia y DataWarehouse en SQL Server.

### Abrir archivo de Visual Studio:

- En la carpeta `Datawarehouse.rar` se encuentran todos los archivos necesarios.

### Cargar Datos en Staging:

- Desde Visual Studio, ejecutar el contenedor `Staging` para importar los datos crudos desde todas las fuentes a la base de datos Staging.

### Limpiar y Modificar Datos:

- Desde Visual Studio, ejecutar el contenedor `Intermedia` que realiza la limpieza y transformación de datos.

### Crear Dimensión Tiempo:

- Ejecutar el script `sp_tiempo` en la base de datos Intermedia.

### Crear Dimensiones y Tabla de Hechos:

- Ejecutar el script `creates.sql` que se encuentra en el repositorio para crear las dimensiones y la tabla de hechos.

### Cargar Datos en DataWarehouse:

- Desde Visual Studio, ejecutar el contenedor `DataWarehouse` que realiza la carga de las dimensiones y matchea datos con la tabla de hechos.

### Crear Visualizaciones en Power BI:

- Importar las vistas SQL a Power BI y crear las visualizaciones necesarias para analizar los datos.

## Visualización en Visual Studio

Para que tengas más claro qué es lo que se visualiza en Visual Studio, debería ser esto:

![VisualStudio 2022](https://github.com/Tomas8x/Datawarehouse---SSIS/blob/main/media/etl_completo.png)

Por temas de peso, no pude subir al repositorio lo que son los backups de las bases de datos Staging, Intermedia y DataWarehouse.

Si tienes alguna duda o sugerencia, no dudes en contactarme.
