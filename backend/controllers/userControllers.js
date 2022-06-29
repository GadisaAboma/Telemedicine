const asyncHandler = require('express-async-handler')
const Admin = require('../models/Admin')
const Patient = require('../models/Patient')
const Doctor = require('../models/Doctor')

const loginUser = asyncHandler(async (req, res) => {
    const { username, password } = req.body

<<<<<<< HEAD
    const admin = await Admin.findOne({username})
    const patient = await Patient.findOne({username})
    const doctor = await Doctor.findOne({username})
    
console.log(admin)
    if(admin && admin.password === password) {
        res.send({
=======
    const admin = await Admin.findOne({ username })
    const patient = await Patient.findOne({ username })
    const doctor = await Doctor.findOne({ username })

    let user;

    if (admin && admin.password === password) {
        user = {
>>>>>>> 10275f023e9d11c6404d8942c11dbd0bef1fbd07
            ...admin,
            role: 'admin'
        }
        res.send(user)
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

module.exports = {
    loginUser
}