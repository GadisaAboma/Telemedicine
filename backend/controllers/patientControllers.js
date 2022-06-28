const Patient = require('../models/Patient')
const asyncHandler = require('express-async-handler')

const registerPatient = asyncHandler( async (req, res) => {
    console.log("coming")
   const { name,username, password,  } = req.body
   const patient = new Patient({
    name,username,
    password,
   })

   const newPatient = await patient.save()
   res.send(newPatient)
})


module.exports= {
    registerPatient,
}