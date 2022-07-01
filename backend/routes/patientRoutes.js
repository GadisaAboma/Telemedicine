const express = require('express')
const { registerPatient, searchDoctor } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/seachDoctor', searchDoctor)

module.exports = router