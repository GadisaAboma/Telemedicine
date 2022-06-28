const express = require('express')
const { registerPatient, loginPatient } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/login', loginPatient)

module.exports = router