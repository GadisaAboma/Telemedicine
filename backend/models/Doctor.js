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
    isActive: {
        type: Boolean,
        default: false
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
        patientId: {
            type: String,
            required: true,
        }
      }],

    messages: [{
        user:{
            type:String,
            required:true
        },
        content: [{
            sender: {
                type:String,
                required: true,
                },
                message:{
                    type:String,
                    required: true,
                },
                reciever:{
                    type:String,
                    required: true,
                }
        }]
    }]

})


module.exports = mongoose.model('Doctor', doctorSchema)