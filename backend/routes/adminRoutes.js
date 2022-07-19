const express = require('express')
const { registerAdmin, allRequests } = require('../controllers/adminControllers')

const router = express.Router()

router.post('/registerAdmin', registerAdmin)
router.get('/requests', allRequests)

module.exports = router