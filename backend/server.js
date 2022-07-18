var express = require('express');
var app = require('express')();
const path = require('path')
var server = require('http').Server(app);
var io = require('socket.io')(server);
const dotenv = require('dotenv')
const cors = require('cors')
const { connectDB } = require('./db/database')


// const express = require('express');
//const app = express();
// const http = require('http');
// const server = http.createServer(app);
// const { Server } = require("socket.io");
// const io = socketio();

// const app = express()
// const path = require('path')


var allUsers = [];


//static folder
app.use(express.static(path.join(__dirname, 'public')));

function emitUsers() {
    io.emit('users', allUsers);
    console.log('users', allUsers);
}
function removeUser(user) {
    allUsers = allUsers.filter(function (ele) {
        return ele != user;
    });
}

io.on("connection", (socket) => {

    console.log("New websoccet connection")

    var userName = socket.request._query.userName;
    allUsers.push(userName);
    emitUsers();
    // var msg = `🔥👤 ${userName} has joined! 😎🔥`;
    var msg = "${userName} has joined! "
    console.log(msg)

    //broadcast when a user connects
    io.emit('message', {
        "message": msg
    }
    );
    socket.on('disconnect', () => {

        var disMsg = `${userName} has disconnected! 😭😭`;
        console.log(disMsg);
        io.emit('message', {
            "message": disMsg,
        });
        removeUser(userName);
        emitUsers()
    });

    socket.on('message', (data) => {
        console.log(`👤 ${data.userName} : ${data.message}`)
        io.emit('message', data);
    });



});

// const server = http.createServer(app)
// const io = socketio(server)

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
