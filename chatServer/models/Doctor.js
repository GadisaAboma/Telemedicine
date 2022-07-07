const mongoose = require('mongoose')

const Schema = mongoose.Schema

const doctorSchema = new Schema({
    name: {
        type: String,
        required: true,
    },
    gender: {
        type: String,
        reqiured: true
    },
    username: {
        type: String,
        unique: true,
        required: true
    },
    password: {
        type: String,
        required: true,
    },
    specializedIn: {
        type: String,
        required: true,
    },

})


module.exports = mongoose.model('Doctor', doctorSchema)