var express = require('express');
var app = require('express')();
const mongoose = require("mongoose")
const path = require('path')
var server = require('http').Server(app);
var io = require('socket.io')(server);



const Doctor = require("./models/Doctor")
const Patient = require("./models/Patient")
const { connectDB } = require("./db/database")

connectDB()

var allUsers = [];


//static folder
app.use(express.static(path.join(__dirname, 'web')));

function emitUsers() {
    io.emit('users', allUsers);
    console.log('users', allUsers);
}
function removeUser(user) {
    allUsers = allUsers.filter(function (ele) {
        return ele != user;
    });
}

//socket listeners

var connectedUser = []
var socketId
io.on('connection', function (socket) {
    var userName = socket.request._query.userName;
    allUsers.push(userName);
    emitUsers();
    var msg = `🔥👤 ${userName} has joined! 😎🔥`;
    console.log(msg)

    // attach incoming listener for new user
    var userName = socket.request._query.userName;
    connectedUser[userName] = socket.id
    console.log(connectedUser)
    //broadcast when a user connects
    io.emit('message', {
        "message": msg
    }
    );

    socket.on("send_message", async function (data) {

        socketId = connectedUser[data.reciever]


        ////////////////////////////////////////
        // let reciever is patient and sender is doctor

        var reciever = await Patient.findOne({ username: data.reciever })
        var sender = await Doctor.findOne({ username: data.sender })

        var index = -1;
        var new_reciever_message = {
            user: data.sender,
            content: []
        }
        var new_sender_message = {
            user: data.reciever,
            content: []
        }

        ////////////////////////////////////////////
        // check if reciever is patient and sender is doctor
        if (reciever != null) {

            reciever.messages.map((message) => {
                index += 1
                if (message.user == data.sender) {
                    new_reciever_message.content = message.content
                    new_reciever_message.content.push(data)
                    return;
                }
            })
            if (index == 0) {
                reciever.messages.push(new_reciever_message)
                index = -1
            } else {
                reciever.messages[index] = new_reciever_message
                index = -1
            }

            sender.messages.map((message) => {
                index += 1
                if (message.user == data.reciever) {
                    new_sender_message.content = message.content
                    new_sender_message.content.push(data)
                    return;
                }
            })

            if (index == 0) {
                sender.messages.push(new_sender_message)
                index = -1
            } else {
                sender.messages[index] = new_sender_message
                index = -1
            }


            // save message to both patient and doctor

            await reciever.save()
            await sender.save()
            new_reciever_message.content = []
            new_reciever_message.user = ''
            new_sender_message.content = []
            new_sender_message.user = ""
        }

        ////////////////////////////////////////////////////
        // if reciever is doctor and sender is patient

        else {

            // if reciever is Doctor
            reciever = await Doctor.findOne({ username: data.reciever })
            sender = await Patient.findOne({ username: data.sender })

            new_reciever_message.user = data.sender
            new_sender_message.user = data.reciever

            reciever.messages.map((message) => {
                index += 1
                if (message.user == data.sender) {
                    new_reciever_message.content = message.content
                    new_reciever_message.content.push(data)
                    return;
                }
            })

            if (index == 0) {
                reciever.messages.push(new_reciever_message)
                index = -1
            } else {
                reciever.messages[index] = new_reciever_message
                index = -1
            }


            sender.messages.map((message) => {
                index += 1
                if (message.user == data.reciever) {
                    new_sender_message.content = message.content
                    new_sender_message.content.push(data)
                    return;
                }
            })

            if (index == 0) {
                sender.messages.push(new_sender_message)
                index = -1
            } else {
                sender.messages[index] = new_sender_message
                index = -1
            }

            new_reciever_message.content = []
            new_reciever_message.user = ''
            new_sender_message.content = []
            new_sender_message.user = ""


            ////////////////////////////////////////////////////
            // if reciever is doctor and sender is patient
            await reciever.save()
            await sender.save()
        }
        io.to(socketId).emit("new_message", data)



    })

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




})
const PORT = 8080;

server.listen(PORT, '0.0.0.0', () => {
    console.log('Server up and running at', PORT);
})
