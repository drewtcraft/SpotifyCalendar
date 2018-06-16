const pg = require('pg-promise')();
const config = require('../config/config.js');
const db = pg(config);

module.exports = {

  getEvents() {
    return db.many (`
      SELECT * FROM calendarEvents
      `)
  },

  postEvent(body) {
    return db.none (`
      INSERT INTO calendarEvents (
        user_id,
        year,
        month,
        day,
        hour,
        minute,
        title,
        description
      ) VALUES (
        $/user_id/,
        $/year/,
        $/month/,
        $/day/,
        $/hour/,
        $/minute/,
        $/title/,
        $/description/
      )`)
  },

  editEvent(id, body) {
    return db.one (`
      UPDATE calendarEvents SET
        year = ${body.year},
        month = ${body.month},
        day = ${body.day},
        hour = ${body.hour},
        minute = ${body.minute},
        title = ${body.title},
        description = ${body.description}
      WHERE id = ${id}
      RETURNING *
      `)
  },

  deleteEvent(id) {
    return db.none (`
      DELETE FROM calendarEvents
      WHERE id = ${id}
      `)
  }

}
