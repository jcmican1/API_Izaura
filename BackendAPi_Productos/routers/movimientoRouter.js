const express = require('express');
const conexion = require('../conexion');
const router= express.Router();

//Obtener todos los Movimientos
router.get('/', (req, res) => {
    const query = 'SELECT * FROM Movimiento;'
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message)

        if (resultado.length > 0) {
            res.json(resultado)
        } else {
            res.json(`No hay registros de movimientos`)
        }
    })
})

//Obtener Movimiento por ID
router.get('/:id', (req, res) => {
    const { id } = req.params

    const query = `SELECT * FROM Movimiento WHERE IdMovimiento=${id};`
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message)

        if (resultado.length > 0) {
            res.json(resultado)
        } else {
            res.json(`ID de movimiento no corresponde a ningún registro`)
        }
    })
})

//Agregar un nuevo Movimiento
router.post('/agregar', (req, res) => {
    const movimiento = {
        FechaMovimiento: req.body.FechaMovimiento,
        CantidadProducto: req.body.CantidadProducto,
        PrecioProductoMovimiento: req.body.PrecioProductoMovimiento,
        Motivo_IdMotivo: req.body.Motivo_IdMotivo,
        UbicacionAlmacen_IdUbicacionAlmacen: req.body.UbicacionAlmacen_IdUbicacionAlmacen,
        Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor: req.body.Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor,
        P_H_P_M_P_P_M_P_I: req.body.P_H_P_M_P_P_M_P_I,
        Usuario_idUsuario: req.body.Usuario_idUsuario
    }

    const query = `INSERT INTO Movimiento SET ?;`
    conexion.query(query, movimiento, (error, resultado) => {
        if (error) return console.error(error.message)

        res.json(`Se insertó correctamente el registro de movimiento`)
    })
})

//Actualizar Movimiento por ID
router.put('/actualizar/:id', (req, res) => {
    const { id } = req.params
    const {
        FechaMovimiento,
        CantidadProducto,
        PrecioProductoMovimiento,
        Motivo_IdMotivo,
        UbicacionAlmacen_IdUbicacionAlmacen,
        Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor,
        P_H_P_M_P_P_M_P_I,
        Usuario_idUsuario
    } = req.body

    const query = `UPDATE Movimiento SET
        FechaMovimiento='${FechaMovimiento}',
        CantidadProducto=${CantidadProducto},
        PrecioProductoMovimiento=${PrecioProductoMovimiento},
        Motivo_IdMotivo=${Motivo_IdMotivo},
        UbicacionAlmacen_IdUbicacionAlmacen=${UbicacionAlmacen_IdUbicacionAlmacen},
        Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor=${Proveedor_has_Producto_Materia_Prima_Proveedor_NITProveedor},
        P_H_P_M_P_P_M_P_I=${P_H_P_M_P_P_M_P_I},
        Usuario_idUsuario=${Usuario_idUsuario}
        WHERE IdMovimiento=${id};`

    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message)

        res.json(`Se actualizó correctamente el registro de movimiento`)
    })
})

//Borrar Movimiento por ID
router.delete('/borrar/:id', (req, res) => {
    const { id } = req.params

    const query = `DELETE FROM Movimiento WHERE IdMovimiento=${id};`
    conexion.query(query, (error, resultado) => {
        if (error) console.error(error.message)

        res.json(`Se eliminó correctamente el registro de movimiento`)
    })
})

module.exports=router;