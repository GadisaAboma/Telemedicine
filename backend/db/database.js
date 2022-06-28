const mongoose = require('mongoose')

const connectDB = async () => {
    const response = await mongoose.connect(process.env.MONGOOSE_URI)
    console.log('MongoDB Connected to: ' + response.connection.host)
}

module.exports = {
    connectDB
}