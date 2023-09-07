// plantillaProductoRouter.js

const express = require('express');
const router = express.Router();
const conexion = require('../conexion'); // Importa tu conexión a la base de datos aquí

// Endpoint para manipular la tabla Usuario
router.get('/', (req, res) => {
    const query = 'SELECT Usuario.idUsuario, Usuario.NombreUsuario, Usuario.Apellido, Usuario.Correo, Usuario.Clave, Rol.DescripcionRol, Estado.DescripcionEstado FROM Usuario INNER JOIN Rol ON Usuario.Rol_IdRol = Rol.IdRol INNER JOIN Estado ON Usuario.Estado_idEstado = Estado.idEstado';
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message);

        if (resultado.length > 0) {
            res.json(resultado);
        } else {
            res.json(`No hay registros`);
        }
    });
});


router.get('/:id', (req, res) => {
    const { id } = req.params

    const query = `SELECT * FROM Usuario WHERE idUsuario=${id};`
    conexion.query(query, (error, resultado) => {
        if (error) return console.error(error.message)

        if (resultado.length > 0) {
            res.json(resultado)
        } else {
            res.json(`No hay registros`)
        }
    })
})


// Endpoint para crear un nuevo usuario
router.post('/agregar', (req, res) => {
    const nuevoUsuario = {
        NombreUsuario: req.body.NombreUsuario,
        Apellido: req.body.Apellido,
        Correo: req.body.Correo,
        Clave: req.body.Clave,
        Rol_IdRol: req.body.Rol_IdRol,
        Estado_idEstado: req.body.Estado_idEstado
    };

    const query = 'INSERT INTO Usuario SET ?';
    conexion.query(query, nuevoUsuario, (error) => {
        if (error) return console.error(error.message);

        res.json('Se insertó correctamente el nuevo usuario');
    });
});


// Endpoint para actualizar un usuario existente
router.put('/actualizar/:id', (req, res) => {
    const { id } = req.params;
    const { NombreUsuario, Apellido, Correo, Clave, Rol_IdRol, Estado_idEstado } = req.body;

    const query = `UPDATE Usuario SET NombreUsuario='${NombreUsuario}', Apellido='${Apellido}', Correo='${Correo}', Clave='${Clave}', Rol_IdRol=${Rol_IdRol}, Estado_idEstado=${Estado_idEstado} WHERE idUsuario=${id};`;
    conexion.query(query, (error) => {
        if (error) return console.error(error.message);

        res.json(`Se actualizó correctamente el usuario`);
    });
});


// Endpoint para eliminar un usuario
router.delete('/borrar/:id', (req, res) => {
    const { id } = req.params;

    const query = `DELETE FROM Usuario WHERE idUsuario=${id};`;
    conexion.query(query, (error) => {
        if (error) console.error(error.message);

        res.json(`Se eliminó correctamente el usuario`);
    });
});

router.post('/login', (req, res) => {
    const nuevoUsuario = {
        Correo: req.body.Correo,
        Clave: req.body.Clave
    };

    const query = `SELECT * FROM usuario WHERE Correo = '${nuevoUsuario.Correo}' AND Clave = '${nuevoUsuario.Clave}';`
    conexion.query(query, (error,resultado) => {
        if (error) return console.error(error.message);

        if (resultado.length > 0) {
            res.json(true)
        } else {
            res.json(false)
        }
    });
});

module.exports = router;
