const express = require('express');
const conexion = require('../conexion');
const router = express.Router();

// Obtener todos los motivos
router.get('/', (req, res) => {
    const query = 'SELECT * FROM Motivo;';
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message);

        if (resultado.length > 0) {
            res.json(resultado);
        } else {
            res.json(`No hay registros de motivos`);
        }
    });
});

// Obtener un motivo por su ID
router.get('/:id', (req, res) => {
    const { id } = req.params;

    const query = `SELECT * FROM Motivo WHERE IdMotivo=${id};`;
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message);

        if (resultado.length > 0) {
            res.json(resultado);
        } else {
            res.json(`ID no corresponde a ningún motivo`);
        }
    });
});

// Agregar un nuevo motivo
router.post('/agregar', (req, res) => {
    const motivo = {
        DescripcionMovimiento: req.body.DescripcionMovimiento,
    };

    const query = `INSERT INTO Motivo SET ?;`;
    conexion.query(query, motivo, (error, resultado) => {
        if (error) return console.error(error.message);

        res.json(`Se insertó correctamente el motivo`);
    });
});

// Actualizar un motivo por su ID
router.put('/actualizar/:id', (req, res) => {
    const { id } = req.params;
    const { DescripcionMovimiento } = req.body;

    const query = `UPDATE Motivo SET DescripcionMovimiento='${DescripcionMovimiento}' WHERE IdMotivo='${id}';`;
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message);

        res.json(`Se actualizó correctamente el motivo`);
    });
});

// Eliminar un motivo por su ID
router.delete('/borrar/:id', (req, res) => {
    const { id } = req.params;

    const query = `DELETE FROM Motivo WHERE IdMotivo=${id};`;
    conexion.query(query, (error, resultado) => {
        if (error) console.error(error.message);

        res.json(`Se eliminó correctamente el motivo`);
    });
});

module.exports=router;