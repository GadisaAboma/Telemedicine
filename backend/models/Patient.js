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
        unique: true
    },

    gender: {
        type: String,
        required: true
    },
    email: {
        type: String,
        unique: true,
        required: true
    },
    password: {
        type: String,
        required: true,
    },

    notifications: [{

    }],

    newNotificationCount: {
        type: Number,
        default: 0
    },

    appointments: [{
        description: {
            type: String,
            required: true,
        },
        date: {
            type: String,
            required: true,
        },
        doctorId: {
            type: String,
            required: true,
        }
    }],

    messages: [{
        user: {
            type: String,
            required: true
        },
        content: [{
            sender: {
                type: String,
                required: true,
            },
            message: {
                type: String,
                required: true,
            },
            reciever: {
                type: String,
                required: true,
            }
        }]
    }]

})

module.exports = mongoose.model('Patient', patientSchema)