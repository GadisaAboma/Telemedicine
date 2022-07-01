const express = require('express')
const http = require('http')
const dotenv = require('dotenv')
const cors = require('cors')
const { connectDB } = require('./db/database')
const socketio = require('socket.io')

// importing our custom routes
const patientRoutes = require('./routes/patientRoutes')
const doctorRoutes = require('./routes/doctorRoutes')
const adminRoutes = require('./routes/adminRoutes')
const userRoutes = require('./routes/userRoutes')

const app = express()
const server = http.createServer(app)
const io = socketio(server)

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

io.on('connection', () => {
    console.log('New Websocket connection');
})

app.use(notFound)
app.use(errorHandler)


const port = process.env.PORT || 4000

server.listen(port, () => {
    console.log('Server is up and listening on port: ' + port)
})