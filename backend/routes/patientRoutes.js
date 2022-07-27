const express = require('express')


const { registerPatient, searchDoctor,fetchPatient,patient } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/searchDoctor', searchDoctor)
// router.post('/fetchMessage', fetchMessage)
// router.post('/fetchChattedDoctor', fetchChattedDoctor)
router.post('/patient', patient)

router.get('/doctorsList', async (req, res)=> {
      const doctors =  await Doctor.find({})
      res.send(doctors);
})

module.exports = router