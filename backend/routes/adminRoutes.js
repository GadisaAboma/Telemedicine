const express = require('express')
const { registerAdmin } = require('../controllers/adminControllers')

const router = express.Router()

router.post('/registerAdmin', registerAdmin)

module.exports = router