const express = require('express')
const router = express.Router()
const { loginUser, startTextChat } = require('../controllers/userControllers')

router.post('/login', loginUser)
//router.post('/startTextChat', startTextChat);



module.exports = router