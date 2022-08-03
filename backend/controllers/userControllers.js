const asyncHandler = require('express-async-handler')
const Admin = require('../models/Admin')
const Patient = require('../models/Patient')
const Doctor = require('../models/Doctor')
const Post = require('../models/place')

const loginUser = asyncHandler(async (req, res) => {
    const { username, password } = req.body

    const admin = await Admin.findOne({ username })
    const patient = await Patient.findOne({ username })
    const doctor = await Doctor.findOne({ username })

    if (admin && admin.password === password) {
        res.send({
            ...admin,
            role: 'admin'

        })
    } else if (patient && patient.password === password) {

        user = {
            ...patient,
            role: 'patient'
        }
        res.send(user)
    } else if (doctor && doctor.password === password) {
        user = {
            ...doctor,
            role: 'doctor'
        }
        res.send(user)

    } else {
        res.status(404)
        throw new Error("Invalid Credentials")
    }

})

const fetchAppointments = asyncHandler(async (req, res) => {
    const { id, userType } = req.body

    let user

    if (userType === 'patients') {
        user = await Patient.findById(id)

    } else {
        user = await Doctor.findById(id)
    }

    res.send(user.appointments)

})


const createPost = asyncHandler(async (req, res) => {
    const post = new Post({
        description: req.body.description,
        imageUrl: req.file.path,
        //creator: req.user._id
    })
    const newPost = await post.save()

    if (newPost) {
        res.send('success')
    } else {
        res.status(404)
        throw new Error('Unable to create place!')
    }
})

const getAllPosts = asyncHandler(async (req, res) => {
    console.log('coming')
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


// const startTextChat = asyncHandler( async (req, res) => {

// })

module.exports = {
    loginUser,
    fetchAppointments,
    getAllPosts,
    createPost
    // startTextChat
}