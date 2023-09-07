CREATE DATABASE simpconsultas;
USE simpconsultas;

CREATE TABLE Rol (
    IdRol INT NOT NULL AUTO_INCREMENT,
    DescripcionRol VARCHAR(45) NOT NULL,
    PRIMARY KEY (IdRol)
);

CREATE TABLE Estado (
    idEstado INT NOT NULL AUTO_INCREMENT,
    DescripcionEstado VARCHAR(45) NOT NULL,
    PRIMARY KEY (idEstado)
);

CREATE TABLE Notificaciones (
    idNotificaciones INT NOT NULL AUTO_INCREMENT,
    Notificacionescol VARCHAR(45) NOT NULL,
    PRIMARY KEY (idNotificaciones)
);

CREATE TABLE Usuario (
    idUsuario INT NOT NULL AUTO_INCREMENT,
    NombreUsuario VARCHAR(45) NOT NULL,
    Apellido VARCHAR(45) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Clave VARCHAR(45) NULL,
    Rol_IdRol INT NOT NULL,
    Estado_idEstado INT NOT NULL,
    PRIMARY KEY (idUsuario),
    FOREIGN KEY (Rol_IdRol) REFERENCES Rol (IdRol) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Estado_idEstado) REFERENCES Estado (idEstado) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Usuario_has_Notificaciones (
    Usuario_idUsuario INT NOT NULL,
    Notificaciones_idNotificaciones INT NOT NULL,
    PRIMARY KEY (Usuario_idUsuario, Notificaciones_idNotificaciones),
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario (idUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Notificaciones_idNotificaciones) REFERENCES Notificaciones (idNotificaciones) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Proveedor (
    NITProveedor INT NOT NULL AUTO_INCREMENT,
    NombreProveedor VARCHAR(45) NOT NULL,
    NumeroTelefonoProveedor BIGINT NOT NULL,
    DireccionProveedor VARCHAR(45) NOT NULL,
    PRIMARY KEY (NITProveedor)
);

CREATE TABLE Categoria (
    idCategoria INT NOT NULL AUTO_INCREMENT,
    DescripcionCategoria VARCHAR(45) NOT NULL,
    PRIMARY KEY (idCategoria)
);

CREATE TABLE UnidadMedida (
    IdUnidadMedida INT NOT NULL AUTO_INCREMENT,
    UnidadMedida VARCHAR(45) NOT NULL,
    PRIMARY KEY (IdUnidadMedida)
);

CREATE TABLE Producto_Materia_Prima (
    IdProductoMateriaPrima INT NOT NULL AUTO_INCREMENT,
    NombreProducto VARCHAR(45) NOT NULL,
    Descripcion VARCHAR(45) NOT NULL,
    Categoria_idCategoria INT NOT NULL,
    UnidadMedida_IdUnidadMedida INT NOT NULL,
    PRIMARY KEY (IdProductoMateriaPrima),
    FOREIGN KEY (Categoria_idCategoria) REFERENCES Categoria (idCategoria) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (UnidadMedida_IdUnidadMedida) REFERENCES UnidadMedida (IdUnidadMedida) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Motivo (
    IdMotivo INT NOT NULL AUTO_INCREMENT,
    DescripcionMovimiento VARCHAR(45) NOT NULL,
    PRIMARY KEY (IdMotivo)
);

CREATE TABLE UbicacionAlmacen (
    IdUbicacionAlmacen INT NOT NULL AUTO_INCREMENT,
    NombreAlmacen VARCHAR(45) NOT NULL,
    PRIMARY KEY (IdUbicacionAlmacen)
);

CREATE TABLE Proveedor_has_Producto_Materia_Prima (
    Proveedor_NITProveedor INT NOT NULL AUTO_INCREMENT,
    Producto_Materia_Prima_IdProductoMateriaPrima INT NOT NULL,
    PRIMARY KEY (Proveedor_NITProveedor, Producto_Materia_Prima_IdProductoMateriaPrima),
    FOREIGN KEY (Proveedor_NITProveedor) REFERENCES Proveedor (NITProveedor) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Producto_Materia_Prima_IdProductoMateriaPrima) REFERENCES Producto_Materia_Prima (IdProductoMateriaPrima) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Movimiento (
    IdMovimiento INT NOT NULL AUTO_INCREMENT,
    FechaMovimiento DATE,
    CantidadProducto INT NOT NULL,
    PrecioProductoMovimiento INT NULL,
    Motivo_IdMotivo INT NOT NULL,
    UbicacionAlmacen_IdUbicacionAlmacen INT NOT NULL,
    Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor INT NOT NULL,
    P_H_P_M_P_P_M_P_I INT NOT NULL,
    Usuario_idUsuario INT NOT NULL,
    PRIMARY KEY (IdMovimiento),
    FOREIGN KEY (Motivo_IdMotivo) REFERENCES Motivo (IdMotivo) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (UbicacionAlmacen_IdUbicacionAlmacen) REFERENCES UbicacionAlmacen (IdUbicacionAlmacen) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor, P_H_P_M_P_P_M_P_I) REFERENCES Proveedor_has_Producto_Materia_Prima (Proveedor_NITProveedor, Producto_Materia_Prima_IdProductoMateriaPrima) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Usuario_idUsuario) REFERENCES Usuario (idUsuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Existencias (
    IdExistencias INT NOT NULL AUTO_INCREMENT,
    CantidadExistencias INT NOT NULL,
    CantidadConsumida INT NOT NULL,
    PuntoCompraProducto INT NOT NULL,
    PuntoMaximoProducto INT NOT NULL,
    FechaUltimaModificacion DATE NOT NULL,
    Producto_Materia_Prima_IdProductoMateriaPrima INT NOT NULL,
    PRIMARY KEY (IdExistencias, Producto_Materia_Prima_IdProductoMateriaPrima),
    FOREIGN KEY (Producto_Materia_Prima_IdProductoMateriaPrima) REFERENCES Producto_Materia_Prima (IdProductoMateriaPrima) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PlantillaProducto (
    idPlantillaProducto INT NOT NULL AUTO_INCREMENT,
    NombreProductoPlantilla VARCHAR(45) NOT NULL,
    ValorVenta VARCHAR(45) NOT NULL,
    PRIMARY KEY (idPlantillaProducto)
);

CREATE TABLE PlantillaProducto_has_ProductoMateriaPrima (
    PlantillaProducto_idPlantillaProducto INT NOT NULL,
    Producto_Materia_Prima_IdProductoMateriaPrima INT NOT NULL,
    PRIMARY KEY (PlantillaProducto_idPlantillaProducto, Producto_Materia_Prima_IdProductoMateriaPrima),
    FOREIGN KEY (PlantillaProducto_idPlantillaProducto) REFERENCES PlantillaProducto (idPlantillaProducto) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Producto_Materia_Prima_IdProductoMateriaPrima) REFERENCES Producto_Materia_Prima (IdProductoMateriaPrima) ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO `estado`(`idEstado`, `DescripcionEstado`) VALUES ('1','Activo');
INSERT INTO `rol`(`IdRol`, `DescripcionRol`) VALUES ('1','Administrador');
INSERT INTO `usuario`(`idUsuario`, `NombreUsuario`, `Apellido`, `Correo`, `Clave`, `Rol_IdRol`, `Estado_idEstado`) VALUES ('1','root','aroot','root','123','1','1');
INSERT INTO `usuario`(`idUsuario`, `NombreUsuario`, `Apellido`, `Correo`, `Clave`, `Rol_IdRol`, `Estado_idEstado`) VALUES ('2','Juan','Mican','j@exmple.com',AES_ENCRYPT("ClaveTremenda","512"),'1','1');


-- Inserción en la tabla Estado
INSERT INTO `estado`(`idEstado`, `DescripcionEstado`) VALUES ('2','Inactivo');
-- Inserción en la tabla Rol
INSERT INTO `rol`(`IdRol`, `DescripcionRol`) VALUES ('2','Usuario Normal');
-- Inserción en la tabla Usuario
INSERT INTO `usuario`(`idUsuario`, `NombreUsuario`, `Apellido`, `Correo`, `Clave`, `Rol_IdRol`, `Estado_idEstado`) VALUES ('3','Luis','Pérez','luis@example.com','miClave123','2','1');
INSERT INTO `usuario`(`idUsuario`, `NombreUsuario`, `Apellido`, `Correo`, `Clave`, `Rol_IdRol`, `Estado_idEstado`) VALUES ('4','Ana','Gómez','ana@example.com',AES_ENCRYPT("OtraClaveSegura","512"),'2','1');
INSERT INTO `usuario`(`idUsuario`, `NombreUsuario`, `Apellido`, `Correo`, `Clave`, `Rol_IdRol`, `Estado_idEstado`) VALUES ('5','María','López','maria@example.com','maria123','2','2');
-- Inserción en la tabla Proveedor
INSERT INTO `proveedor`(`NITProveedor`, `NombreProveedor`, `NumeroTelefonoProveedor`, `DireccionProveedor`) VALUES (12345,'Proveedor1',123456789,'Dirección1');
-- Inserción en la tabla Categoria
INSERT INTO `categoria`(`idCategoria`, `DescripcionCategoria`) VALUES (2,'Categoría 2');
-- Inserción en la tabla UnidadMedida
INSERT INTO `unidadmedida`(`IdUnidadMedida`, `UnidadMedida`) VALUES (2,'Unidad 2');
-- Inserción en la tabla Producto_Materia_Prima
INSERT INTO `producto_materia_prima`(`IdProductoMateriaPrima`, `NombreProducto`, `Descripcion`, `Categoria_idCategoria`, `UnidadMedida_IdUnidadMedida`) VALUES (2,'Producto2','Descripción2',2,2);
-- Inserción en la tabla Motivo
INSERT INTO `motivo`(`IdMotivo`, `DescripcionMovimiento`) VALUES (2,'Motivo 2');
-- Inserción en la tabla UbicacionAlmacen
INSERT INTO `ubicacionalmacen`(`IdUbicacionAlmacen`, `NombreAlmacen`) VALUES (2,'Almacen 2');
-- Inserción en la tabla Proveedor_has_Producto_MateriaPrima
INSERT INTO `Proveedor_has_Producto_Materia_Prima`(`Proveedor_NITProveedor`, `Producto_Materia_Prima_IdProductoMateriaPrima`) VALUES (12345,2);
-- Inserción en la tabla Movimiento
INSERT INTO `movimiento`(`IdMovimiento`, `FechaMovimiento`, `CantidadProducto`, `PrecioProductoMovimiento`, `Motivo_IdMotivo`, `UbicacionAlmacen_IdUbicacionAlmacen`, `Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor`, `P_H_P_M_P_P_M_P_I`, `Usuario_idUsuario`) VALUES (2,'2023-08-27',10,100,2,2,12345,2,3);
-- Inserción en la tabla Existencias
INSERT INTO `existencias`(`IdExistencias`, `CantidadExistencias`, `CantidadConsumida`, `PuntoCompraProducto`, `PuntoMaximoProducto`, `FechaUltimaModificacion`, `Producto_Materia_Prima_IdProductoMateriaPrima`) VALUES (2,50,20,10,100,'2023-08-27',2);
-- Inserción en la tabla PlantillaProducto
INSERT INTO `plantillaproducto`(`idPlantillaProducto`, `NombreProductoPlantilla`, `ValorVenta`) VALUES (2,'Plantilla2','Valor2');
-- Inserción en la tabla PlantillaProducto_has_ProductoMateriaPrima
INSERT INTO `plantillaproducto_has_productomateriaprima`(`PlantillaProducto_idPlantillaProducto`, `Producto_Materia_Prima_IdProductoMateriaPrima`) VALUES (2,2);
