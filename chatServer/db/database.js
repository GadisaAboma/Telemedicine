const mongoose = require('mongoose')

const connectDB = async () => {
    const response = await mongoose.connect("mongodb://localhost:27017/Telemedicine")
    console.log('MongoDB Connected to: ' + response.connection.host)
}

module.exports = {
    connectDB
}