const express = require('express');
const router = express.Router();
const conexion = require('../conexion');


router.get('/', (req, res) => {
    const query = 'SELECT * FROM plantillaproducto'
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message)

        if (resultado.length > 0) {
            res.json(resultado)
        } else {
            res.json(`No hay registros`)
        }
    })
})

router.get('/:id', (req, res) => {
    const { id } = req.params

    const query = `SELECT * FROM plantillaproducto WHERE idPlantillaProducto=${id};`
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message)

        if (resultado.length > 0) {
            res.json(resultado)
        } else {
            res.json(`No hay registros`)
        }
    })
})

router.post('/agregar', (req, res) => {
    const Producto_Plantilla = {
        NombreProductoPlantilla: req.body.NombreProductoPlantilla,
        ValorVenta: req.body.ValorVenta
    }

    const query = `INSERT INTO plantillaproducto SET ?`
    conexion.query(query, Producto_Plantilla, (error) => {
        if (error) return console.error(error.message)

        res.json(`Se insertó correctamente el producto plantilla`)
    })
})

router.put('/actualizar/:id', (req, res) => {
    const { id } = req.params
    const { NombreProductoPlantilla, ValorVenta } = req.body

    const query = `UPDATE plantillaproducto SET NombreProductoPlantilla='${NombreProductoPlantilla}', ValorVenta='${ValorVenta}' WHERE idPlantillaProducto='${id}';`
    conexion.query(query, (error) => {
        if (error) return console.error(error.message)

        res.json(`Se actualizó correctamente el usuario`)
    })
})

router.delete('/borrar/:id', (req, res) => {
    const { id } = req.params

    const query = `DELETE FROM plantillaproducto WHERE idPlantillaProducto=${id};`
    conexion.query(query, (error) => {
        if (error) console.error(error.message)

        res.json(`Se eliminó correctamente el Producto Plantilla`)
    })
})

module.exports = router;
