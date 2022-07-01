const express = require('express')
const { registerPatient, searchDoctor } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/searchDoctor', searchDoctor)

router.get('/doctorsList', async (req, res)=> {
      const doctors =  await Doctor.find({})
      res.send(doctors);
})

module.exports = router