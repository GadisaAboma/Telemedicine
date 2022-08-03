const mongoose = require('mongoose')

const Schema = mongoose.Schema

const postSchema = new Schema({

    description: {
        type: String,
        required: true,
    },

    imageUrl: {
        type: String,
      
    },
    date: {
        type: Date,
        default: new Date()
    },
    doctorName: {
        type: String,
        required: true,
    }
    // creator: {
    //     type: mongoose.Schema.Types.ObjectId,
    //     /* required: true,
    //     ref: 'User' */
    // }

})

module.exports = mongoose.model('Posts', postSchema)