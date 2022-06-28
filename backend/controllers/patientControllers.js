const Patient = require('../models/Patient')

const registerPatient = async (req, res) => {
   const { name, password } = req.body
   const patient = new Patient({
    name,
    password
   })

   const newPatient = await patient.save()

   res.send(newPatient)
} 


module.exports= {
    registerPatient,
}