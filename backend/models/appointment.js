const mongoose = require('mongoose')

const Schema = mongoose.Schema

const appointmentSchema = new Schema({
    description: {
        type: String,
        required: true,
    },
    doctorId: {
        type: String,
        reqiured: true
    },
    patientId: {
        type: String,
        required: true
    },
    date: {
        type: String,
        required: true,
    },
    doctorName: {
        type: String,
        required: true,
    },
    patientName: {
        type: String,
        required: true
    }

})

module.exports = mongoose.model('Appointment', appointmentSchema)