const express = require('express')
const { registerDoctor } = require('../controllers/doctorControllers')

const router = express.Router()

router.post('/registerDoctor', registerDoctor)

module.exports = router