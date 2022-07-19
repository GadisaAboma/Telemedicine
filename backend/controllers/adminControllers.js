const asyncHandler = require('express-async-handler')
const Admin = require('../models/Admin')
const Doctor = require('../models/Doctor')

const registerAdmin = asyncHandler(async (req, res) => {
    const admin = new Admin(req.body)

    const newAdmin = await admin.save()

    if (newAdmin) {
        res.status(201).send(newAdmin)
    } else {
        res.status(404)
        throw new Error("Unable to register!")
    }
})

const allRequests = asyncHandler(async (req, res) => {
    const requests = await Doctor.find({
        isActive: false
    })

    if(requests.length > 0) {
        res.send(requests)
    } else {
        res.status(404)
        throw new Error("No requests to show!")
    }

})

const approveRequest = asyncHandler(async (req, res) => {
    const { id } = req.body
    const doctor = await Doctor.findById(id)
    doctor.isActive = true
    await doctor.save()
})

module.exports = {
    registerAdmin,
    allRequests,
    approveRequest
}