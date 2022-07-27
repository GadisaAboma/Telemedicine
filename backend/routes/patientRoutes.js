const express = require('express')
<<<<<<< HEAD
const { registerPatient, searchDoctor,fetchMessage ,fetchChattedDoctor, patient} = require('../controllers/patientControllers')
=======
const { registerPatient, searchDoctor,fetchPatient } = require('../controllers/patientControllers')
>>>>>>> parent of c6d9ecc (chatbot added)

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/searchDoctor', searchDoctor)
<<<<<<< HEAD
router.post('/fetchMessage', fetchMessage)
router.post('/fetchChattedDoctor', fetchChattedDoctor)
router.post('/patient', patient)
=======
router.post('/fetchPatient', fetchPatient)
>>>>>>> parent of c6d9ecc (chatbot added)

router.get('/doctorsList', async (req, res)=> {
      const doctors =  await Doctor.find({})
      res.send(doctors);
})

module.exports = router