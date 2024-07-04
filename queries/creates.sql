-- Crear tabla Dimensiones Tiempo
CREATE TABLE dim_time_G15 (
    key_time INT PRIMARY KEY,
    day TINYINT,
    month TINYINT,
    year SMALLINT,
    NombreMes NVARCHAR(20),
    Trimestre TINYINT,
    Semestre TINYINT,
    DiaSemana TINYINT,
    NombreDiaSemana NVARCHAR(20),
    Semana TINYINT,
    DiaAño SMALLINT
);

-- Crear tabla Dimensiones Regiones
CREATE TABLE dim_region_G15 (
    cod_postal INT PRIMARY KEY,
    zona NVARCHAR(255),
    estado NVARCHAR(255),
    ciudad NVARCHAR(255)
);

-- Crear tabla Dimensiones Empleado
CREATE TABLE dim_employee_G15 (
    key_employee INT PRIMARY KEY IDENTITY(1,1),
    employee_id INT,
    nombre NVARCHAR(100),
    genero NVARCHAR(2),
    categoria NVARCHAR(50),
    fecha_ingreso DATE,
    fecha_nac DATE,
    nivel_educacion NVARCHAR(100)
);

-- Crear tabla Dimensiones Producto
CREATE TABLE dim_product_G15 (
    key_product INT PRIMARY KEY IDENTITY(1,1),
    product_id INT,
    desc_product VARCHAR(255),
    capacidad VARCHAR(255),
    unidad NVARCHAR(255)
);

-- Crear tabla Dimensiones Cliente
CREATE TABLE dim_customer_G15 (
    key_customer INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    tipo_cliente NVARCHAR(50),
    nombre NVARCHAR(100),
    fecha_nac DATE,
    ciudad NVARCHAR(255),
    estado NVARCHAR(255),
    cod_postal INT,
	FOREIGN KEY (cod_postal) REFERENCES dim_region_G15(cod_postal)
);


-- Crear tabla Hecho Ventas
CREATE TABLE fact_sales_G15 (
    fact_id INT PRIMARY KEY IDENTITY(1,1), -- Clave primaria autoincremental para identificar registros de ventas
    billing_id INT, -- ID de facturación
    sale_date DATETIME, -- Fecha de la venta
    key_customer INT, -- Clave foránea que referencia la tabla de clientes
    key_employee INT, -- Clave foránea que referencia la tabla de empleados
    key_product INT, -- Clave foránea que referencia la tabla de productos
    key_time INT, -- Clave foránea que referencia la tabla de tiempo
    cantidad_litros FLOAT, -- Cantidad de litros vendidos
    region NVARCHAR(50), -- Región de la venta
    quantity INT, -- Cantidad de productos vendidos
    price FLOAT, -- Precio unitario
    FOREIGN KEY (key_customer) REFERENCES dim_customer_G15(key_customer), -- Claves foráneas que aseguran la integridad referencial
    FOREIGN KEY (key_employee) REFERENCES dim_employee_G15(key_employee),
    FOREIGN KEY (key_product) REFERENCES dim_product_G15(key_product),
    FOREIGN KEY (key_time) REFERENCES dim_time_G15(key_time)
);