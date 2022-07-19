const express = require('express')
const { registerAdmin, allRequests, approveRequest } = require('../controllers/adminControllers')

const router = express.Router()

router.post('/registerAdmin', registerAdmin)
router.get('/requests', allRequests)
router.post('/approve', approveRequest)

module.exports = router