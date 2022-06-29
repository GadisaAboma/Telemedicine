const asyncHandler = require('express-async-handler')
const Doctor = require('../models/Doctor')

const registerDoctor = asyncHandler(async (req, res) => {
    const doctor = new Doctor(req.body)

    const newDoctor = await doctor.save()

    if(newDoctor) {
        res.status(201).send(newDoctor)
    } else {
        res.status(404)
        throw new Error("Unable to register!")
    }
})

module.exports = {
registerDoctor
}