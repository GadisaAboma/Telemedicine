const express = require('express')
const router = express.Router()
const { loginUser, startTextChat, fetchAppointments } = require('../controllers/userControllers')

router.post('/login', loginUser)
//router.post('/startTextChat', startTextChat);
router.post('/fetchAppointments', fetchAppointments)



module.exports = router