const express = require('express')
const { registerPatient } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)

module.exports = router