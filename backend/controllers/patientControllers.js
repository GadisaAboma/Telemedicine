const Patient = require('../models/Patient')
const asyncHandler = require('express-async-handler')

const registerPatient = asyncHandler(async (req, res) => {
    const { name, username, password, } = req.body
    const patient = new Patient({
        name,
        username,
        password,
    })

    const newPatient = await patient.save()
    res.send(newPatient)
})


const loginPatient = asyncHandler(async (req, res) => {
    const { username, password } = req.body

    const patient = await Patient.findOne(username)

    if (patient && patient.password === password) {
        res.send(patient)
    } else {
        res.status(404)
        throw new Error("Invalid Credentials")
    }
})

module.exports = {
    registerPatient,
    loginPatient
}