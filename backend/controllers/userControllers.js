const asyncHandler = require('express-async-handler')
const Admin = require('../models/Admin')
const Patient = require('../models/Patient')
const Doctor = require('../models/Doctor')
const Post = require('../models/place')
const Appointment = require('../models/appointment');

/////////////////////////////////////////////////////

const nodemailer = require("nodemailer");


const jwt = require('jsonwebtoken')


  

  function sendEmail(email, secretCode){

    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'info.telemedicine.babycare@gmail.com',
          pass: 'ylmlvjblewybnffc'
        }
      });
      
      var mailOptions = {
        from: 'info.telemedicine.babycare@gmail.com',
        to: email,
        subject: 'Conformation message from babycare telemedicine application ',
        text: 'here is your secret code from babycare telemedicine!',
        html:'<h1>&secretCode is '+ secretCode +"</h1>"
      };

      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
          console.log('Email sent: ' + info.response);
        }
      });
  }

   

  ///////////////////////////////////////////////////

const forgotPassword = asyncHandler(async (req, res)=>{
    const { secretCode,email } = req.body

    const admin = await Admin.findOne({ email })
    const patient = await Patient.findOne({ email })
    const doctor = await Doctor.findOne({ email })
    if(admin){
        sendEmail(email, secretCode)
        res.send("sent")
    } else if(patient){
        sendEmail(email, secretCode)
        res.send("sent")
    } else if(doctor){
        sendEmail(email, secretCode)
        res.send("sent")
    } else{
        res.status(404)
        throw new Error("invalid email")
    }
    

    
})
const loginUser = asyncHandler(async (req, res) => {


      
    const { username, password } = req.body

    const admin = await Admin.findOne({ username })
    const patient = await Patient.findOne({ username })
    const doctor = await Doctor.findOne({ username })

    if (admin && admin.password === password) {
        res.send({
            ...admin,
            role: 'admin',
            token: generateAuthToken(admin._id),

        })
    } else if (patient && patient.password === password) {

        user = {
            ...patient,
            token: generateAuthToken(patient._id),
            role: 'patient'
        }
        res.send(user)
    } else if (doctor && doctor.password === password) {
        user = {
            ...doctor,
            token: generateAuthToken(doctor._id),
            role: 'doctor'
        }
        res.send(user)

    } else {
        res.status(404)
        throw new Error("Invalid Credentials")
    }

})

const generateAuthToken = (id) => {
    return jwt.sign({ id }, "telemedicine")
}

const fetchAppointments = asyncHandler(async (req, res) => {
    const { id, userType } = req.body

    let appointments

    if (userType === 'patients') {
        // user = await Patient.findById(id)
        appointments = await Appointment.find({
            patientId: id
        })

    } else {
        appointments = await Appointment.find({
            doctorId: id
        })
    }
    res.send(appointments)

})


const createPost = asyncHandler(async (req, res) => {
    const post = new Post({
        description: req.body.description,
        imageUrl: req.file.path,
        doctorName: req.body.doctorName,
        creator: req.user._id
    })
    const newPost = await post.save()

    if (newPost) {
        res.send('success')
    } else {
        res.status(404)
        throw new Error('Unable to create place!')
    }
})

const getMyPosts = asyncHandler(async (req, res) => {
    const user = await Doctor.findById(req.user._id)
    await user.populate('posts')
    res.send(user.posts)
})

const getAllPosts = asyncHandler(async (req, res) => {

    const allPlaces = await Post.find()

    var currentIndex = allPlaces.length, temporaryValue, randomIndex;
    while (0 !== currentIndex) {
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;
        temporaryValue = allPlaces[currentIndex];
        allPlaces[currentIndex] = allPlaces[randomIndex];
        allPlaces[randomIndex] = temporaryValue;
    }

    res.send(allPlaces)

})


const deletePost = asyncHandler(async (req, res) => {
    const { id } = req.body
    let post = await Post.findById(id)

    if (post) {
        await post.remove()
        res.send("success")
    } else {
        res.status(404)
        throw new Error("Failed to delete post")
    }

})

const confirmPassword = asyncHandler(async (req, res) => {
    const { id, password, type } = req.body
    let user
    if (type === 'doctors') {
        user = await Doctor.findById(id)
        if (password === user.password) {
            res.send("success")
        } else {
            res.status(404)
            throw new Error("Incorrect password")
        }
    } else if (type === 'patients') {
        user = await Patient.findById(id)
        if (password === user.password) {
            res.send("success")
        } else {
            res.status(404)
            throw new Error("Incorrect password")
        }
    } else if (type === 'admins') {
        user = await Admin.findById(id)
        if (password === user.password) {
            res.send("success")
        } else {
            res.status(404)
            throw new Error("Incorrect password")
        }
    } else {
        res.status(404)
        throw new Error("Incorrect password")
    }
})

const resetPassord = asyncHandler(async (req, res) => {
    console.log(req.body)
    const { password, email } = req.body
    try{
       let admin = await Admin.findOne({email})
       let doctor = await Doctor.findOne({email})
       let patient = await Patient.findOne({email})
    //   console.log(patient)
       if(admin){
        admin.password = password
        await admin.save()
        res.send("success")
       } else if(doctor){
        doctor.password = password
        await doctor.save()
        res.send("success")
       } else if(patient){
        patient.password = password
        await patient.save()
        res.send("success")
       } else{
        res.status(404)
        throw new Error("Failed to save password")
       }
    } catch (e){
        res.status(404)
        throw new Error("Failed to save password")
    }
})

const updateUserInfo = asyncHandler(async (req, res) => {
    const { name, password, id, type, username } = req.body
    let user;

    if (type === 'doctors') {
        user = await Doctor.findById(id)

    } else if (type === 'patients') {
        user = await Patient.findById(id)

    } else if (type === 'admins') {
        user = await Admin.findById(id)

    } else {
        res.status(404)
        throw new Error("Failed to save password")
    }
    user.name = name
    user.password = password
    user.username = username

    const savedUser = await user.save()

    if (savedUser) {
        res.send("success")
    } else {
        res.status(404)
        throw new Error("Failed to save password")
    }
})


const deleteAppointment = asyncHandler(async (req, res) => {
    const { id, doctorId, patientId, type } = req.body
    let appointment
    if (type === 'patients') {
        appointment = await Appointment.findById(
            id
        )
    } else {
        appointment = await Appointment.findById(
            id,
        )
    }

    const success = await appointment.remove();

    if (success) {
        res.send("success")
    } else {
        res.status(404)
        throw new Error("Failed to remove")
    }

})

module.exports = {
    loginUser,
    fetchAppointments,
    getAllPosts,
    createPost,
    getMyPosts,
    deletePost,
    confirmPassword,
    updateUserInfo,
    deleteAppointment,
    forgotPassword,
    resetPassord
}