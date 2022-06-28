const Patient = require('../models/Patient')
const asyncHandler = require('express-async-handler')

const registerPatient = asyncHandler( async (req, res) => {
   const { name, password, username } = req.body
   const patient = new Patient({
    name,
    password
   })

   const newPatient = await patient.save()
   res.send(newPatient)
})


module.exports= {
    registerPatient,
}