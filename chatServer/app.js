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
var removedsUSer
function removeUser(user) {
    allUsers= allUsers.filter(function(ele){ 
        return ele != user; 
    });   
    connectedUser.filter(e=>{
        console.log(e)
        return Object.keys(e) != user
    })   
    console.log(connectedUser)
}

//socket listeners

var connectedUser = []
var reciverSocketId
var senderSocketId
var userName 

io.on('connection', function (socket) {
    console.log(socket.request._query.userName)

    
    userName = socket.request._query.userName;
    if(userName != "" && !allUsers.includes(userName)){
        allUsers.push(userName);
    }
    socket.request._query.userName = ""
    emitUsers();

    var msg = `🔥👤 ${userName} has joined! 😎🔥`;
    console.log(msg)

    // attach incoming listener for new user
    connectedUser[userName] = socket.id

    //broadcast when a user connects
    

    socket.on("send_message", async (data) => {
        console.log(data)
        console.log(connectedUser) 



        reciverSocketId = connectedUser[data.reciever]
        senderSocketId = connectedUser[data.sender]


        ////////////////////////////////////////
        // let reciever is patient and sender is doctor

        var reciever = await Patient.findOne({ username: data.reciever })
        var sender = await Doctor.findOne({ username: data.sender })

        var index = -1;
        var isPrevousUser = false;
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
        reciever.messages.map((message) =>{
            index += 1 
            if(message.user == data.sender ){
                isPrevousUser = true
                new_reciever_message.content = message.content
                new_reciever_message.content.push(data)
                return; 
            } 
        })
        if(index == 0 || !isPrevousUser ){
            reciever.messages.push(new_reciever_message)
            index = -1  
        } else {
            reciever.messages[index] = new_reciever_message 
            index = -1
        }
        
        sender.messages.map((message) =>{
            index += 1
            if(message.user ==data.reciever ){
                isPrevousUser = true
                new_sender_message.content = message.content
                new_sender_message.content.push(data)
                return; 
            } 
        })

        if(index == 0 || !isPrevousUser ){
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
        sender = await Patient.findOne({ username:data.sender })
        reciever = await Doctor.findOne({  username: data.reciever }) 
     
        new_reciever_message.user = data.sender
        new_sender_message.user = data.reciever
    
     reciever.messages.map((message) =>{
        index += 1
        if(message.user == data.sender  ){
            isPrevousUser = true
            new_reciever_message.content = message.content
            new_reciever_message.content.push(data)
            return;
        } 
        })

        if(index == 0 || !isPrevousUser){
        reciever.messages.push(new_reciever_message)
        index = -1  
        } else {
        reciever.messages[index] = new_reciever_message
        index = -1
        }
        // io.to(socketId).emit("new_message", data)

        sender.messages.map((message) =>{
        index += 1
        if(message.user ==data.reciever ){
            isPrevousUser = true
            new_sender_message.content = message.content
            new_sender_message.content.push(data)
            return;
        }}) 
        }
    
         if(index == 0 || !isPrevousUser ){
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
        
        if(reciverSocketId){
        }
        io.to(reciverSocketId).emit("new_message",data)
        // io.to(senderSocketId).emit("new_message",data)


        var disMsg = `${userName} has disconnected! 😭😭`;
        console.log(disMsg);
        io.emit('message', {
            "message": disMsg,
        });
        removeUser(userName);
        emitUsers()
    });


        // socket.on('message', (data) => {
        // console.log(`👤 ${data.userName} : ${data.message}`)
        // io.emit('message', data);
        // });

       
     

})
const PORT = 8080;

server.listen(PORT, '0.0.0.0', () => {
    console.log('Server up and running at', PORT);
})
