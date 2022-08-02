var express = require('express');
var app = require('express')();
const path = require('path')
var server = require('http').Server(app);
var io = require('socket.io')(server);
const dotenv = require('dotenv')
const cors = require('cors')
const { connectDB } = require('./db/database')





var allUsers = [];




// importing our custom routes
const patientRoutes = require('./routes/patientRoutes')
const doctorRoutes = require('./routes/doctorRoutes')
const adminRoutes = require('./routes/adminRoutes')
const userRoutes = require('./routes/userRoutes')

// const server = http.createServer(app)
// const io = socketio(server)

const { notFound, errorHandler } = require('./middlewares/errorMiddleware')
const Patient = require('./models/Patient')
const Doctor = require('./models/Doctor')

// Server Configuration
dotenv.config()
app.use('/uploads', express.static('uploads'))
app.use(cors())
connectDB()

app.use(express.json())








// Registering routes
app.use("/api/patients", patientRoutes)
app.use('/api/doctors', doctorRoutes)
app.use('/api/admin', adminRoutes)
app.use('/api/user', userRoutes)

app.get('/patients', async (req, res) => {
    const patients = await Patient.find({});
    res.send(patients)
})
app.get('/doctors', async (req, res) => {
    const patients = await Doctor.find({});
    res.send(patients)
})


app.use(notFound)
app.use(errorHandler)

///////////////////////////////////////////

// var express = require('express');
// var app = require('express')();
// const path = require('path')
// var server = require('http');
// var socketio = require('socket.io');


// const namespace = io.of("/login")
// namespace.use((socket, next) =>{
//     console.log(socket)
//     next()
// })
//socket listeners



const PORT = 3000;

server.listen(PORT, () => {
    console.log('Server up and running at', PORT);
});
