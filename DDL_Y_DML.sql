-- Crear la base de datos simpUv
create database simpUv;
use simpUv;

-- Crear tabla Rol
create table Rol
(
    IdRol int not null auto_increment,
    DescripcionRol varchar(45) not null,
    primary key (IdRol)
);

-- Crear tabla Estado
create table Estado
(
    IdEstado int not null auto_increment,
    DescripcionEstado varchar(45) not null,
    primary key (IdEstado)
);

-- Crear tabla Usuario
create table Usuario
(
    IdUsuario int not null auto_increment,
    NombreUsuario varchar(45) not null,
    Apellido varchar(45) not null,
    Correo varchar(100) not null,
    Clave varchar(45) null,
    Rol_IdRol int not null,
    Estado_idEstado int not null,
    primary key (IdUsuario),
    foreign key (Rol_IdRol) references Rol (IdRol) on update cascade on delete cascade,
    foreign key (Estado_idEstado) references Estado (IdEstado) on update cascade on delete cascade
);

-- Crear tabla Notificaciones
create table Notificaciones
(
    IdNotificaciones int not null auto_increment,
    Notificacionescol varchar(45) not null,
    primary key (IdNotificaciones)
);

-- Crear tabla Usuario_has_Notificaciones
create table Usuario_has_Notificaciones
(
    Usuario_idUsuario int not null,
    Notificaciones_idNotificaciones int not null,
    primary key (Usuario_idUsuario, Notificaciones_idNotificaciones),
    foreign key (Usuario_idUsuario) references Usuario (IdUsuario) on update cascade on delete cascade,
    foreign key (Notificaciones_idNotificaciones) references Notificaciones (IdNotificaciones) on update cascade on delete cascade
);

-- Crear tabla Proveedor
create table Proveedor
(
    NITProveedor int not null auto_increment,
    NombreProveedor varchar(45) not null,
    NumeroTelefonoProveedor bigint not null,
    DireccionProveedor varchar(45) not null,
    primary key (NITProveedor)
);

-- Crear tabla Categoria
create table Categoria
(
    IdCategoria int not null auto_increment,
    DescripcionCategoria varchar(45) not null,
    primary key (IdCategoria)
);

-- Crear tabla Unidad_Medida
create table Unidad_Medida
(
    IdUnidadMedida int not null auto_increment,
    UnidadMedida varchar(45) not null,
    primary key (IdUnidadMedida)
);

-- Crear tabla Producto_Materia_Prima
create table Producto_Materia_Prima
(
    IdProductoMateriaPrima int not null auto_increment,
    NombreProducto varchar(45) not null,
    DescripcionProductoMateriaPrima varchar(45) not null,
    IdCategoria int not null,
    IdUnidadMedida int not null,
    primary key (IdProductoMateriaPrima),
    foreign key (IdCategoria) references Categoria (IdCategoria) on update cascade on delete cascade,
    foreign key (IdUnidadMedida) references Unidad_Medida (IdUnidadMedida) on update cascade on delete cascade
);

-- Crear tabla Motivo
create table Motivo
(
    IdMotivo int not null auto_increment,
    DescripcionMovimiento varchar(45) not null,
    primary key (IdMotivo)
);

-- Crear tabla UbicacionAlmacen
create table UbicacionAlmacen
(
    IdUbicacionAlmacen int not null auto_increment,
    NombreAlmacen varchar(45) not null,
    primary key (IdUbicacionAlmacen)
);

-- Crear tabla Proveedor_has_Producto_MateriaPrima
create table Proveedor_has_Producto_MateriaPrima
(
    NITProveedor int not null auto_increment,
    IdProductoMateriaPrima int not null,
    primary key (NITProveedor, IdProductoMateriaPrima),
    foreign key (NITProveedor) references Proveedor (NITProveedor) on update cascade on delete cascade,
    foreign key (IdProductoMateriaPrima) references Producto_Materia_Prima (IdProductoMateriaPrima) on update cascade on delete cascade
);

-- Crear tabla Movimiento
create table Movimiento
(
    IdMovimiento int not null auto_increment,
    FechaMovimiento date,
    CantidadProducto int not null,
    PrecioProductoMovimiento int null,
    IdMotivo int not null,
    IdUbicacionAlmacen int not null,
    NITProveedor int not null,
    IdProductoMateriaPrima int not null,
    IdUsuario int not null,
    primary key (IdMovimiento),
    foreign key (IdMotivo) references Motivo (IdMotivo) on update cascade on delete cascade,
    foreign key (IdUbicacionAlmacen) references UbicacionAlmacen (IdUbicacionAlmacen) on update cascade on delete cascade,
    foreign key (NITProveedor, IdProductoMateriaPrima) references Proveedor_has_Producto_MateriaPrima (NITProveedor, IdProductoMateriaPrima) on update cascade on delete cascade,
    foreign key (IdUsuario) references Usuario (IdUsuario) on update cascade on delete cascade
);

-- Crear tabla Existencias
create table Existencias
(
    IdExistencias int not null auto_increment,
    CantidadExistencias int not null,
    CantidadConsumida int not null,
    PuntoCompraProducto int not null,
    PuntoMaximoProducto int not null,
    FechaUltimaModificacion date not null,
    IdProductoMateriaPrima int not null,
    primary key (IdExistencias, IdProductoMateriaPrima),
    foreign key (IdProductoMateriaPrima) references Producto_Materia_Prima (IdProductoMateriaPrima) on update cascade on delete cascade
);

-- Crear tabla PlantillaProducto
create table PlantillaProducto
(
    IdPlantillaProducto int not null auto_increment,
    NombreProductoPlantilla varchar(45) not null,
    ValorVenta varchar(45) not null,
    primary key (IdPlantillaProducto)
);

-- Crear tabla PlantillaProducto_has_ProductoMateriaPrima
create table PlantillaProducto_has_ProductoMateriaPrima
(
    IdPlantillaProducto int not null,
    IdProductoMateriaPrima int not null,
    primary key (IdPlantillaProducto, IdProductoMateriaPrima),
    foreign key (IdPlantillaProducto) references PlantillaProducto (IdPlantillaProducto) on update cascade on delete cascade,
    foreign key (IdProductoMateriaPrima) references Producto_Materia_Prima (IdProductoMateriaPrima) on update cascade on delete cascade
);
-- Insertar datos de prueba en la tabla Rol
INSERT INTO Rol (DescripcionRol) VALUES
    ('Admin'),
    ('Empleado'),
    ('Gerente');

-- Insertar datos de prueba en la tabla Estado
INSERT INTO Estado (DescripcionEstado) VALUES
    ('Activo'),
    ('Inactivo'),
    ('En Espera');

-- Insertar datos de prueba en la tabla Usuario
INSERT INTO Usuario (NombreUsuario, Apellido, Correo, Clave, Rol_IdRol, Estado_idEstado) VALUES
    ('juan123', 'Pérez', 'juan@example.com', 'clave123', 1, 1),
    ('ana456', 'López', 'ana@example.com', 'clave456', 2, 1),
    ('carlos789', 'Gómez', 'carlos@example.com', 'clave789', 2, 3);

-- Insertar datos de prueba en la tabla Notificaciones
INSERT INTO Notificaciones (Notificacionescol) VALUES
    ('Notificación 1'),
    ('Notificación 2'),
    ('Notificación 3');

-- Insertar datos de prueba en la tabla Usuario_has_Notificaciones
INSERT INTO Usuario_has_Notificaciones (Usuario_idUsuario, Notificaciones_idNotificaciones) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 1);

-- Insertar datos de prueba en la tabla Proveedor
INSERT INTO Proveedor (NombreProveedor, NumeroTelefonoProveedor, DireccionProveedor) VALUES
    ('Proveedor 1', 1234567890, 'Calle 123, Ciudad'),
    ('Proveedor 2', 9876543210, 'Avenida 456, Otra Ciudad');

-- Insertar datos de prueba en la tabla Categoria
INSERT INTO Categoria (DescripcionCategoria) VALUES
    ('Categoría 1'),
    ('Categoría 2'),
    ('Categoría 3');

-- Insertar datos de prueba en la tabla Unidad_Medida
INSERT INTO Unidad_Medida (UnidadMedida) VALUES
    ('Unidad 1'),
    ('Unidad 2'),
    ('Unidad 3');

-- Insertar datos de prueba en la tabla Producto_Materia_Prima
INSERT INTO Producto_Materia_Prima (NombreProducto, DescripcionProductoMateriaPrima, IdCategoria, IdUnidadMedida) VALUES
    ('Producto 1', 'Descripción Producto 1', 1, 1),
    ('Producto 2', 'Descripción Producto 2', 2, 2),
    ('Producto 3', 'Descripción Producto 3', 3, 3);

-- Insertar datos de prueba en la tabla Motivo
INSERT INTO Motivo (DescripcionMovimiento) VALUES
    ('Motivo 1'),
    ('Motivo 2'),
    ('Motivo 3');

-- Insertar datos de prueba en la tabla UbicacionAlmacen
INSERT INTO UbicacionAlmacen (NombreAlmacen) VALUES
    ('Almacén 1'),
    ('Almacén 2'),
    ('Almacén 3');

-- Insertar datos de prueba en la tabla Proveedor_has_Producto_MateriaPrima
INSERT INTO Proveedor_has_Producto_MateriaPrima (NITProveedor, IdProductoMateriaPrima) VALUES
    (1, 1),
    (2, 2),
    (1, 3);

-- Insertar datos de prueba en la tabla Movimiento
INSERT INTO Movimiento (FechaMovimiento, CantidadProducto, PrecioProductoMovimiento, IdMotivo, IdUbicacionAlmacen, NITProveedor, IdProductoMateriaPrima, IdUsuario) VALUES
    ('2023-09-01', 100, 50, 1, 1, 1, 1, 1),
    ('2023-09-02', 200, 75, 2, 2, 2, 2, 2),
    ('2023-09-03', 150, 60, 3, 3, 1, 3, 3);

-- Insertar datos de prueba en la tabla Existencias
INSERT INTO Existencias (CantidadExistencias, CantidadConsumida, PuntoCompraProducto, PuntoMaximoProducto, FechaUltimaModificacion, IdProductoMateriaPrima) VALUES
    (500, 200, 100, 400, '2023-09-01', 1),
    (800, 300, 200, 600, '2023-09-02', 2),
    (600, 250, 150, 500, '2023-09-03', 3);

-- Insertar datos de prueba en la tabla PlantillaProducto
INSERT INTO PlantillaProducto (NombreProductoPlantilla, ValorVenta) VALUES
    ('Plantilla 1', '100'),
    ('Plantilla 2', '200'),
    ('Plantilla 3', '150');

-- Insertar datos de prueba en la tabla PlantillaProducto_has_ProductoMateriaPrima
INSERT INTO PlantillaProducto_has_ProductoMateriaPrima (IdPlantillaProducto, IdProductoMateriaPrima) VALUES
    (1, 1),
    (2, 2),
    (3, 3);
