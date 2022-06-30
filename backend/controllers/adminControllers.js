const asyncHandler = require('express-async-handler')
const Admin = require('../models/Admin')

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

module.exports = {
    registerAdmin
}