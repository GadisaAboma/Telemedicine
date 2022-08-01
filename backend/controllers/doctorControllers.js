const asyncHandler = require('express-async-handler')
const Doctor = require('../models/Doctor')
const Admin = require('../models/Admin')
const Patient = require('../models/Patient')

const registerDoctor = asyncHandler(async (req, res) => {

    const { username } = req.body

    const admin = await Admin.findOne({ username })

    if (admin) {
        res.status(400)
        throw new Error('Username already taken')

    }

    const existingDoctor = await Doctor.findOne({ username })

    if (existingDoctor) {
        res.status(400)
        throw new Error('Username already taken')

    }

    const existingPatient = await Patient.findOne({ username })

    if (existingPatient) {
        res.status(400)
        throw new Error('Username already taken')

    }

    const doctor = new Doctor({
        ...req.body, messages: {
            user: "patient",
            content: {
                sender: "Telemedicine",
                message: "welcome",
                reciever: "patient"

            }

        }
    })

    const newDoctor = await doctor.save()

    if (newDoctor) {
        res.status(201).send({ ...newDoctor, role: "doctor" })
    } else {
        res.status(404)
        throw new Error("Unable to register!")
    }
})

const messages = asyncHandler(async (req, res) => {

    const doctors = await Doctor.findOne(req.body)
    var storedMessage = []
    doctors.messages.find(message => {
        if (message.user !== "patient") {
            storedMessage.push(message.user)
        }

    })
    res.send(doctors)

})

const searchPatient = asyncHandler(async (req, res) => {

    const { username } = req.body

    const patient = await Patient.findOne({ username })

    if (patient) {
        res.send(patient)

    } else {
        res.status(400)
        throw new Error('Doctor not found!')
    }

})

const setAppointment = asyncHandler(async (req, res) => {
    console.log('comin')
    const { id, date, description } = req.body
    const user = await Patient.findById(id)

    user.appointments.push({
        date,
        description
    })

    const saved = await user.save()

    console.log(saved)

    if (saved) {
        res.status(201).send("Success")
    } else {
        res.status(404)
        res.send("failed to save")
    }

})

module.exports = {

    registerDoctor,
    messages,
    searchPatient,
    setAppointment
}