const asyncHandler = require('express-async-handler')
const Doctor = require('../models/Doctor')
const Admin = require('../models/Admin')
const Patient = require('../models/Patient')
const Appointment = require('../models/appointment')

//////////////////////////////////
//// PUSH NOTIFICATION
//var admin = require("firebase-admin");
//var serviceAccount = require("../telemedicine-app-for-babycare-firebase-adminsdk-1jc98-32ff2bfae1.json");

// admin.initializeApp({
//     credential: admin.credential.cert(serviceAccount)
//   });


// async function sendNotificationEventCreation(){
//     try{
//         let message = {
//             notification: {
//               title: '$GOOG up 1.43% on the day',
//               body: '$GOOG gained 11.80 points to close at 835.67, up 1.43% on the day.',
//             },
//             data: {
//               channel_id: threadId,
//             },
//             android: {
//               ttl: 3600 * 1000,
//               notification: {
//                 icon: 'stock_ticker_update',
//                 color: '#f45342',
//               },
//             },
//             apns: {
//               payload: {
//                 aps: {
//                   badge: 42,
//                 },
//               },
//             },
//             token: deviceToken,
//           };

//           admin.messaging().send(message)
//             .then((response) => {
//               // Response is a message ID string.
//               console.log('Successfully sent message:', response);
//             })
//             .catch((error) => {
//               console.log('Error sending message:', error);
//             });
//     }catch(e){
//         console.log(e)
//     }
// }


//////////////////////////////////////////////


const registerDoctor = asyncHandler(async (req, res) => {

    const { username } = req.body

    const admin = await Admin.findOne({ username })

    if (admin) {
        res.status(400)
        throw new Error('Username already taken')

    }

    const existingDoctor = await Doctor.findOne({ username })

    if (existingDoctor) {
        res.status(400)
        throw new Error('Username already taken')

    }

    const existingPatient = await Patient.findOne({ username })

    if (existingPatient) {
        res.status(400)
        throw new Error('Username already taken')

    }

    const doctor = new Doctor({
        ...req.body,
        idUrl: req.file.path,
        messages: {
            user: "patient",
            content: {
                sender: "Telemedicine",
                message: "welcome",
                reciever: "patient"

            }

        }
    })

    const newDoctor = await doctor.save()

    if (newDoctor) {
        res.status(201).send({ ...newDoctor, role: "doctor" })
    } else {
        res.status(404)
        throw new Error("Unable to register!")
    }
})

const messages = asyncHandler(async (req, res) => {

    const doctors = await Doctor.findOne(req.body)
    var storedMessage = []
    doctors.messages.find(message => {
        if (message.user !== "patient") {
            storedMessage.push(message.user)
        }

    })
    res.send(doctors)

})

const searchPatient = asyncHandler(async (req, res) => {

    const { username } = req.body

    const patient = await Patient.find({ username })

    if (patient) {
        res.send(patient)

    } else {
        res.status(400)
        throw new Error('Patient not found!')
    }

})



const setAppointment = asyncHandler(async (req, res) => {

    console.log(req.body)
    //sendNotificationEventCreation()

    const { id, date, description, doctorId, doctorName, patientName } = req.body

    const appointment = new Appointment({
        description: description,
        patientId: id,
        doctorId: doctorId,
        date: date,
        doctorName,
        patientName
    })

    const patient = await Patient.findById(id)

    patient.notifications.unshift("Appointment is set for you by " + doctorName + ", check it on your appoitment lists")
    patient.newNotificationCount = patient.newNotificationCount + 1;
    await patient.save();
    const saved = await appointment.save();
    if (saved) {
        res.status(201).send("Success")
    } else {
        res.status(404)
        res.send("failed to save")
    }
})

module.exports = {

    registerDoctor,
    messages,
    searchPatient,
    setAppointment
}