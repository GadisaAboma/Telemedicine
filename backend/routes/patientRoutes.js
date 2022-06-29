const express = require('express')
const { registerPatient, loginPatient } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)

module.exports = router