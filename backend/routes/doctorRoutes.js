const express = require('express')
const { registerDoctor,messages, searchPatient, setAppointment } = require('../controllers/doctorControllers')

const router = express.Router()

const multer = require('multer')

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        cb(null, './uploads/')
    },
    filename: function (req, file, cb) {
        cb(null, file.originalname);
    }
})

const upload = multer({ storage: storage })

router.post('/registerDoctor', upload.single('doctorId'), registerDoctor)
router.post('/messages', messages)
router.post('/searchPatient', searchPatient)
router.post('/setAppointment', setAppointment)

module.exports = router