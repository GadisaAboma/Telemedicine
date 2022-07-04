const express = require('express')
const http = require('http')
const dotenv = require('dotenv')
const cors = require('cors')
const { connectDB } = require('./db/database')
const socketio = require('socket.io')


// const express = require('express');
const app = express();
// const http = require('http');
const server = http.createServer(app);
const { Server } = require("socket.io");
const io = new Server(server);

// const app = express()
const path = require('path')


var allUsers = [];


//static folder
app.use(express.static(path.join(__dirname,'web')));

function emitUsers() {
    io.emit('users',allUsers);    
    console.log('users',allUsers);
}
function removeUser(user) {
    allUsers= allUsers.filter(function(ele){ 
        return ele != user; 
    });   
}



io.of("/login").on("connection",  (socket) => {
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

server.listen(PORT,()=>{
    console.log('Server up and running at',PORT);
});
