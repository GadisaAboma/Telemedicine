const express = require('express')
const router = express.Router()
const { auth } = require('../middlewares/auth')
const { loginUser, confirmPassword, updateUserInfo, startTextChat, fetchAppointments, createPost, getAllPosts, getMyPosts, deletePost } = require('../controllers/userControllers')


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
router.post('/createPost', auth, upload.single('postImage'), createPost)
router.get('/fetchPosts', getAllPosts)
router.get('/getMyPosts', auth, getMyPosts)
router.post('/deletePost', deletePost)
router.post('/confirmPassword', confirmPassword)
router.post('/updateUserInfo', updateUserInfo)



module.exports = router