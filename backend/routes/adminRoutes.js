const express = require('express')
const { registerAdmin, allRequests, approveRequest, rejectRequest } = require('../controllers/adminControllers')

const router = express.Router()

router.post('/registerAdmin', registerAdmin)
router.get('/requests', allRequests)
router.post('/approve', approveRequest)
router.post('/reject', rejectRequest)

module.exports = router