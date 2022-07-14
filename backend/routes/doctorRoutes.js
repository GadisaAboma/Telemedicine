const express = require('express')
const { registerDoctor,messages } = require('../controllers/doctorControllers')

const router = express.Router()

router.post('/registerDoctor', registerDoctor)
router.post('/messages', messages)

module.exports = router