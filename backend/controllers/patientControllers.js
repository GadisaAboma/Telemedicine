const Patient = require('../models/Patient')
const Doctor = require('../models/Doctor')
const Admin = require('../models/Admin')
const asyncHandler = require('express-async-handler')

const registerPatient = asyncHandler(async (req, res) => {
    const { name, username, password, } = req.body

       const admin = await Admin.findOne({username})

       if(admin) {
        res.status(400)
        throw new Error('Username already taken')
        
       }

       const doctor = await Doctor.findOne({username})

       if(doctor) {
        res.status(400)
        throw new Error('Username already taken')

       }

       const existingPatient = await Patient.findOne({username})

       if(existingPatient) {
        res.status(400)
        throw new Error('Username already taken')

       }

    const patient = new Patient({
        name,
        username,
        password,
    })

    const newPatient = await patient.save()
    res.send(newPatient)
})

module.exports = {
    registerPatient,
}