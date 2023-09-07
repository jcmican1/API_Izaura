const express = require('express');
const router = express.Router();
const conexion = require('../conexion');

// Consultar todos los registros de relacion plantilla materia prima
router.get('/relaciones', (req, res) => {
    const query = 'SELECT * FROM PlantillaProducto_has_ProductoMateriaPrima';
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message);

        if (resultado.length > 0) {
            res.json(resultado);
        } else {
            res.json('No hay relaciones en la tabla PlantillaProducto_has_ProductoMateriaPrima');
        }
    });
});

// Consultar por ID en la tabla relacion plantilla materia prima


// Agregar un nuevo registro a la tabla relacion plantilla materia prima
router.post('/relaciones/agregar', (req, res) => {
    const { IdPlantillaProducto, IdProductoMateriaPrima } = req.body;

    const nuevaRelacion = {
        IdPlantillaProducto: IdPlantillaProducto,
        IdProductoMateriaPrima: IdProductoMateriaPrima
    };

    const query = 'INSERT INTO PlantillaProducto_has_ProductoMateriaPrima SET ?';
    conexion.query(query, nuevaRelacion, (error) => {
        if (error) {
            console.error(error.message);
            res.status(500).json('Error al agregar la relación');
        } else {
            res.json('Se insertó correctamente la relación');
        }
    });
});

// Actualizar un registro en la tabla relacion plantilla materia prima por su ID


// Borrar un registro en la tabla relacion plantilla materia prima por su ID
router.delete('/relaciones/borrar/:idPlantilla/:idMateriaPrima', (req, res) => {
    const { idPlantilla, idMateriaPrima } = req.params;

    const query = `DELETE FROM PlantillaProducto_has_ProductoMateriaPrima WHERE IdPlantillaProducto=${idPlantilla} AND IdProductoMateriaPrima=${idMateriaPrima}`;
    
    conexion.query(query, (error) => {
        if (error) {
            console.error(error.message);
            res.status(500).json('Error al eliminar la relación');
        } else {
            res.json('Se eliminó correctamente la relación');
        }
    });
});

module.exports = router;