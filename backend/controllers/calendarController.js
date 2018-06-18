//import model
const model = require('../models/calendarModel.js')

//export all controller functions for use in routes
module.exports={

  getEvents(req, res, next) {
    model.getEvents()
      .then((events)=>{
        res.json(events)
      })
      .catch((err)=>{
        console.log('error in getEvents controller', err)
        next(err)
      })
  },

  postEvent(req, res, next) {
    let reqBody = JSON.parse(Object.keys(req.body)[0])
    console.log('post event !!', reqBody)
    model.postEvent(reqBody)
      .catch((err)=>{
        console.log('error in postEvent controller', err)
        next(err)
      })
  },

  editEvent(req, res, next) {
    model.editEvent(req.params.event_id, req.body)
      .then((updatedEvent)=>{
        res.send(updatedEvent)
      })
      .catch((err)=>{
        console.log('error in editEvent controller', err)
        next(err)
      })
  },

  deleteEvent(req, res, next) {
    model.deleteEvent(req.params.event_id)
      .catch((err)=>{
        console.log('error in deleteEvent controller', err)
        next(err)
      })
  }

}
