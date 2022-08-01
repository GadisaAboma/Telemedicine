const express = require('express')
const Doctor = require("../models/Doctor")

const { registerPatient, searchDoctor,fetchPatient, patient } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/searchDoctor', searchDoctor)
router.post('/patient', patient)
// router.post('/fetchChattedDoctor', fetchChattedDoctor)
router.post('/fetchPatient', fetchPatient)

router.get('/doctorsList', async (req, res)=> {
      const doctors =  await Doctor.find({})
      res.send(doctors);
      
})

module.exports = router