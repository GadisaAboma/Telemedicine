const express = require('express')
const app = express()
const dotenv = require('dotenv')
const cors = require('cors')
const { connectDB } = require('./db/database')

dotenv.config()
app.use(cors())
connectDB()

const port = process.env.PORT || 4000

app.listen(port, () => {
    console.log('Server is up and listening on port: ' + port)

})