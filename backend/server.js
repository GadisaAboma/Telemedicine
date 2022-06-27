const express = require('express')
const app = express()
const dotenv = require('dotenv')

dotenv.config()

const port = process.env.PORT || 4000

app.listen(port, () => {

    console.log('Server is up and listening on port: ' + port)

})