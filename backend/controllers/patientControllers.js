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
        gender
    })

    const newPatient = await patient.save()
    res.send(newPatient)
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

module.exports = {
    registerPatient,
    searchDoctor
}