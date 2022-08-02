const express = require('express')
const router = express.Router()
const { loginUser, startTextChat, fetchAppointments, createPost, getAllPosts } = require('../controllers/userControllers')


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

router.post('/login', loginUser)
//router.post('/startTextChat', startTextChat);
router.post('/fetchAppointments', fetchAppointments)
router.post('/createPost',upload.single('postImage'), createPost)
router.get('/fetchPosts', getAllPosts)



module.exports = router