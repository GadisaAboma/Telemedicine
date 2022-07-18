const mongoose = require('mongoose')

const connectDB = async () => {
    const response = await mongoose.connect("mongodb://127.0.0.1:27017/Telemedicine")
    console.log('MongoDB Connected to: ' + response.connection.host)
}

module.exports = {
    connectDB
}