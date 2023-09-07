const express = require('express')
const bodyParser = require('body-parser')
const conexion = require('./conexion'); 
const app = express()


app.use(function (req, res, next) {
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', '*');
    res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next()
})

app.use(bodyParser.json())

const PUERTO = 3000

app.listen(PUERTO, () => {
    console.log(`Servidor corriendo en el puerto ${PUERTO} bien`);
})


// Importa los enrutadores
const plantillaProductoRouter = require('./routers/plantillaProductoRouter');
const estadosRouter = require('./routers/estadosRouter');
const rolesRouter = require('./routers/rolesRouter');
const usuariosRouter = require('./routers/usuariosRouter');
const notificacionesRouter = require('./routers/notificacionesRouter');
const usuarioNotificacionesRouter = require('./routers/usuarioNotificacionesRouter');

const proveedorRouter = require('./routers/proveedorRouter');
const ubicacionAlmacenRouter = require('./routers/ubicacionAlmacenRouter');
const existenciasRouter = require('./routers/existenciasRouter');
const movimientoRouter = require('./routers/movimientoRouter');
const motivoRouter = require('./routers/motivoRouter');

// Usa los enrutadores
app.use('/plantillaproducto', plantillaProductoRouter);
app.use('/estados', estadosRouter);
app.use('/roles', rolesRouter);
app.use('/usuarios', usuariosRouter);
app.use('/notificaciones', notificacionesRouter);
app.use('/usuario-notificaciones', usuarioNotificacionesRouter);

app.use('/proveedor', proveedorRouter);
app.use('/ubicacion-almacen/', ubicacionAlmacenRouter);
app.use('/existencias', existenciasRouter);
app.use('/movimiento', movimientoRouter);
app.use('/motivo', motivoRouter);

//comienzo de rutas

app.get('/', (req, res) => {
    res.send('API DE SIMP informacion de uso : /ruta normal ')
})