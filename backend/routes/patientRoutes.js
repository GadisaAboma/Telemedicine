const express = require('express')
const Doctor = require("../models/Doctor")

const { registerPatient, searchDoctor, fetchPatient, patient, fetchDoctor, newNotificationCount, fetchNotifications } = require('../controllers/patientControllers')

const router = express.Router()

router.post('/registerPatient', registerPatient)
router.post('/searchDoctor', searchDoctor)
router.post('/patient', patient)
router.post('/fetchDoctor', fetchDoctor)
// router.post('/fetchChattedDoctor', fetchChattedDoctor)
router.post('/fetchPatient', fetchPatient)
router.post('/countNotification', newNotificationCount)
router.post('/fetchNotifications', fetchNotifications)

router.get('/doctorsList', async (req, res) => {
      const doctors = await Doctor.find({})
      res.send(doctors);

})

module.exports = router