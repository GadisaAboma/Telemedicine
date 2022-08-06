const jwt = require('jsonwebtoken')
const Doctor = require('../models/Doctor')
const asyncHandler = require('express-async-handler')

const auth = asyncHandler(async (req, res, next) => {

    if (req.headers.authorization && req.headers.authorization.startsWith('Bearer ')) {
        const token = req.headers.authorization.replace('Bearer ', '')
        const decoded = jwt.verify(token, 'telemedicine')

        try {
            const user = await Doctor.findById(decoded.id)
            if (user) {
                req.user = user
                next()
            } else {
                res.status(401)
                throw new Error('Please Authenticate!')
            }
        } catch (err) {
            res.status(401)
            throw new Error('Please Authenticate!')
        }
    } else {
        res.status(401)
        throw new Error('Please Authenticate!')
    }

})

module.exports = {
    auth
}