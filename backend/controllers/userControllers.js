const asyncHandler = require('express-async-handler')
const Admin = require('../models/Admin')
const Patient = require('../models/Patient')
const Doctor = require('../models/Doctor')

const loginUser = asyncHandler(async (req, res) => {
    const { username, password } = req.body

    const admin = await Admin.findOne({username})
    const patient = await Patient.findOne({username})
    const doctor = await Doctor.findOne({username})
    
    if(admin && admin.password === password) {
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


const startTextChat = asyncHandler( async (req, res) => {

})

module.exports = {
    loginUser,
    startTextChat
}