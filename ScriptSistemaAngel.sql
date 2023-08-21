CREATE DATABASE BD_INVENTARIO_ANGEL

GO

USE BD_INVENTARIO_ANGEL

GO

create table PROVEEDOR(
IdProveedor int primary key identity,
Documento varchar(50),
RazonSocial varchar(50),
Correo varchar(50),
Telefono varchar(50),
Fecha_Creacion datetime default getdate()
)

go


create table CLIENTE(
IdCliente int primary key identity,
Documento varchar(50),
NombreCompleto varchar(50),
Correo varchar(50),
Telefono varchar(50),
Fecha_Creacion datetime default getdate()
)

go


create table USUARIOS(
IdUsuario int primary key identity,
NombreCompleto varchar(50),
Usuario varchar(50),
Pass varchar(50),
Privilegio varchar(50),
Fecha_Creacion datetime default getdate()
)

go


create table PRODUCTO(
IdProducto int primary key identity,
Codigo varchar(50),
Descripcion varchar(50),
Stock int not null default 0,
Precio_Compra decimal(10, 2) default 0,
Precio_Venta decimal(10, 2) default 0,
Fecha_Creacion datetime default getdate()
)

go


select * from producto

INSERT INTO PRODUCTO (Codigo, Descripcion, Stock, Precio_Compra, Precio_Venta)
VALUES
    ('COD001', 'jugo', 50, 10.50, 15.99),
    ('COD002', 'Pan', 100, 20.00, 29.99),
    ('COD003', 'CONFLE', 25, 5.75, 9.99),
    ('COD004', 'HARINA', 75, 8.00, 12.99),
    ('COD005', 'REFRESCO', 30, 15.25, 22.50),
    ('COD006', 'Malta Morena', 60, 12.50, 19.75),
    ('COD007', 'Aguacate', 90, 18.75, 26.25),
    ('COD008', 'Pepino', 15, 7.00, 10.99),
    ('COD009', 'oregano', 40, 9.25, 14.50),
    ('COD010', 'Pizza', 70, 11.00, 17.99);





create table COMPRA(
IdCompra int primary key identity,
IdUsuario int references USUARIOS(IdUsuario),
IdProveedor int references PROVEEDOR(IdProveedor),
Monto decimal(10, 2),
Fecha_Creacion datetime default getdate()
)

go

create table DETALLE_COMPRA(
IdDetalleCompra int primary key identity,
IdCompra int references COMPRA(IdCompra),
IdProducto int references PRODUCTO(IdProducto),
Precio_Compra decimal(10, 2),
Precio_Venta decimal(10, 2),
Cantidad int,
Monto decimal(10, 2),
Fecha_Creacion datetime default getdate()
)

go

create table VENTAA(
IdVenta int primary key identity,
Usuario varchar(50),
Pago decimal(10, 2),
SubTotal decimal(10, 2),
Itbis decimal(10, 2),
Total decimal(10, 2),
Cambio decimal(10, 2),
Fecha_Creacion datetime default getdate()
)

go


create table DETALLE_DE_VENTA(
IdDetalleVenta int primary key identity,
Codigo varchar(100),
Descripcion varchar(100),
Precio_Venta decimal(10, 2),
Cantidad decimal(10, 2),
SubTotal decimal(10, 2),
Total decimal(10, 2),
Fecha_Creacion datetime default getdate()
)


ALTER TABLE DETALLE_DE_VENTA
DROP COLUMN total;


go

select * from DETALLE_DE_VENTA

--------------------------
create proc MostrarUsuarios
as
select * from usuarios
go

exec MostrarUsuarios
---------------------------------------------

create proc EditarUsuarios
@IdUsuario int,
@NombreCompleto nvarchar (100),
@Usuario nvarchar (100),
@Pass nvarchar (100),
@Privilegio nvarchar (100)
as
update usuarios set NombreCompleto=@NombreCompleto,Usuario=@Usuario,Pass=@Pass,Privilegio=@Privilegio
where IdUsuario=@IdUsuario
go

create proc EliminarUsuarios
@IdUsuario int
as
delete from usuarios where IdUsuario=@IdUsuario

exec EliminarUsuarios 14

--------------------------------------------
create proc MostrarPro
as
select * from producto
go

exec MostrarPro
--------------------------------------------
CREATE PROCEDURE EliminarPro
    @IdProducto INT
AS
BEGIN
    DELETE FROM PRODUCTO
    WHERE IdProducto = @IdProducto;
END;
--------------------------------------------
CREATE PROCEDURE EditarPro
    @IdProducto INT,
    @Codigo VARCHAR(50),
    @Descripcion VARCHAR(50),
    @Stock INT,
    @Precio_Compra DECIMAL(10, 2),
    @Precio_Venta DECIMAL(10, 2)
AS
BEGIN
    UPDATE PRODUCTO
    SET Codigo = @Codigo,
        Descripcion = @Descripcion,
        Stock = @Stock,
        Precio_Compra = @Precio_Compra,
        Precio_Venta = @Precio_Venta
    WHERE IdProducto = @IdProducto;
END;
