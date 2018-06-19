//import dependencies
const express = require('express')
const router = express.Router()
const controller = require('../controllers/calendarController.js')

//route for specific calendar events (get, post, put, delete)
router.route('/events/:event_id')
  .put(controller.editEvent)
  .delete(controller.deleteEvent)

//route for reading all events
router.route('/events')
  .get(controller.getEvents)
  .post(controller.postEvent)

module.exports = router
