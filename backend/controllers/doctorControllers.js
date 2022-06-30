const asyncHandler = require('express-async-handler')
const Doctor = require('../models/Doctor')
const Admin = require('../models/Admin')
const Patient = require('../models/Patient')

const registerDoctor = asyncHandler(async (req, res) => {

   const { username } = req.body

   const admin = await Admin.findOne({username})

       if(admin) {
        res.status(400)
        throw new Error('Username already taken')
        
       }

       const existingDoctor = await Doctor.findOne({username})

       if(existingDoctor) {
        res.status(400)
        throw new Error('Username already taken')

       }

       const existingPatient = await Patient.findOne({username})

       if(existingPatient) {
        res.status(400)
        throw new Error('Username already taken')

       }

    const doctor = new Doctor(req.body)

    const newDoctor = await doctor.save()

    if(newDoctor) {
        res.status(201).send(newDoctor)
    } else {
        res.status(404)
        throw new Error("Unable to register!")
    }
})

module.exports = {
registerDoctor
}