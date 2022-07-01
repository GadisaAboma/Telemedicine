const express = require('express')
const http = require('http')
const dotenv = require('dotenv')
const cors = require('cors')
const { connectDB } = require('./db/database')
const socketio = require('socket.io')


const app = express()
const path = require('path')
var server = require('http').Server(app);
var io = require('socket.io')(server);

// importing our custom routes
const patientRoutes = require('./routes/patientRoutes')
const doctorRoutes = require('./routes/doctorRoutes')
const adminRoutes = require('./routes/adminRoutes')
const userRoutes = require('./routes/userRoutes')

// const server = http.createServer(app)
// const io = socketio(server)

const { notFound, errorHandler } = require('./middlewares/errorMiddleware')

// Server Configuration
dotenv.config()
app.use(cors())
connectDB()
app.use(express.json())

// Registering routes
app.use("/api/patients", patientRoutes)
app.use('/api/doctors', doctorRoutes)
app.use('/api/admin', adminRoutes)
app.use('/api/user', userRoutes)


app.use(notFound)
app.use(errorHandler)


const PORT = 3000;

server.listen(PORT,'0.0.0.0',()=>{
    console.log('Server up and running at',PORT);
});
