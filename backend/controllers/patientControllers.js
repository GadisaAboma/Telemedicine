const Patient = require('../models/Patient')
const Doctor = require('../models/Doctor')
const Admin = require('../models/Admin')
const asyncHandler = require('express-async-handler')

const registerPatient = asyncHandler(async (req, res) => {
    const { name, username, gender, password, } = req.body

    const admin = await Admin.findOne({ username })

    if (admin) {
        res.status(400)
        throw new Error('Username already taken')
    }
    const doctor = await Doctor.findOne({ username })

    if (doctor) {
        res.status(400)
        throw new Error('Username already taken')
    }

    const existingPatient = await Patient.findOne({ username })

    if (existingPatient) {
        res.status(400)
        throw new Error('Username already taken')

    }

    const patient = new Patient({
        name,
        username,
        password,
        gender,
        messages:{
            user:"patient",
            content:{
            sender:"Telemedicine",
            message:"welcome" + name,
            reciever:"patient"

            }

        }
    })

    const newPatient = await patient.save()
    res.send(newPatient)
})

const fetchPatient = asyncHandler(async (req, res) => {
   try {
    const patient = await Patient.findOne(req.body)
    if(patient != null){
        res.send(patient)
    }
    }catch(e){
        res.send(e)
    }
})
const searchDoctor = asyncHandler(async (req, res) => {
    
    const { username } = req.body

    const doctor = await Doctor.findOne({ username })

    if (doctor) {
        res.send(doctor)

    } else {
        res.status(400)
        throw new Error('Doctor not found!')
    }



})
const patient = asyncHandler(async (req, res) => {
    console.log(req.body)
    const { username } = req.body

    const patientData = await Patient.findOne({ username })

    if (patientData) {
        res.send(patientData)

    } else {
        res.status(400)
        throw new Error('patientData not found!')
    }



})

module.exports = {
    registerPatient,
    searchDoctor,fetchPatient


}