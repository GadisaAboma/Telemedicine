const express = require('express')
const { registerPatient, loginPatient } = require('../controllers/patientControllers')
const Doctor = require("../models/Doctor")

const router = express.Router()

router.post('/registerPatient', registerPatient)

router.get('/doctorsList', async (req, res)=> {
      const doctors =  await Doctor.find({})
      res.send(doctors);
})

module.exports = router