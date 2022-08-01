const express = require('express')
const { registerDoctor,messages, searchPatient, setAppointment } = require('../controllers/doctorControllers')

const router = express.Router()

router.post('/registerDoctor', registerDoctor)
router.post('/messages', messages)
router.post('/searchPatient', searchPatient)
router.post('/setAppointment', setAppointment)

module.exports = router