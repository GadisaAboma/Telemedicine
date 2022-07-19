const express = require('express')
const { registerPatient, searchDoctor,fetchMessage ,fetchChattedDoctor} = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/searchDoctor', searchDoctor)
router.post('/fetchMessage', fetchMessage)
router.post('/fetchChattedDoctor', fetchChattedDoctor)

router.get('/doctorsList', async (req, res)=> {
      const doctors =  await Doctor.find({})
      res.send(doctors);
})

module.exports = router