const pg = require('pg-promise')();
const config = require('../config/config.js');
const db = pg(config);

module.exports = {

  getEvents() {
    return db.any (`
      SELECT * FROM calendarevents
      `)
  },

  postEvent(body) {
    console.log('this the body in the model', body)
    return db.none (`
      INSERT INTO calendarEvents (
        user_id,
        year,
        month,
        day,
        start_hour,
        start_minute,
        end_hour,
        end_minute,
        title,
        description
      ) VALUES (
        $/user_id/,
        $/year/,
        $/month/,
        $/day/,
        $/start_hour/,
        $/start_minute/,
        $/end_hour/,
        $/end_minute/,
        $/title/,
        $/description/
      )`, body)
  },

  editEvent(id, body) {
    console.log(body.year)
    return db.none (`
      UPDATE calendarEvents SET
        year = $/year/,
        month = $/month/,
        day = $/day/,
        start_hour = $/start_hour/,
        start_minute = $/start_minute/,
        end_hour = $/end_hour/,
        end_minute = $/end_minute/,
        title = $/title/,
        description = $/description/
      WHERE id = ${id}
      `, body)
  },

  deleteEvent(id) {
    return db.none (`
      DELETE FROM calendarEvents
      WHERE id = ${id}
      `)
  }

}
