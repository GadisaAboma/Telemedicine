const mongoose = require('mongoose')

const Schema = mongoose.Schema

const patientSchema = new Schema({
    name: {
        type: String,
        required: true,
    },
    username: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
    }

})

module.exports = mongoose.model('Patient', patientSchema)