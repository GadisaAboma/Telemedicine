const express = require('express')
const app = express()
const dotenv = require('dotenv')
const cors = require('cors')
const { connectDB } = require('./db/database')
const patientRoutes = require('./routes/patientRoutes')
const { notFound, errorHandler } = require('./middlewares/errorMiddleware')

// Server Configuration
dotenv.config()
app.use(cors())
connectDB()
app.use(express.json())

// Registering routes
app.use("/api/patients", patientRoutes)

app.use(notFound)
app.use(errorHandler)


const port = process.env.PORT || 4000

app.listen(port, () => {
    console.log('Server is up and listening on port: ' + port)
})