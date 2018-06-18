\c calendardb

DROP TABLE IF EXISTS calendarevents;
CREATE TABLE calendarevents (
  id SERIAL PRIMARY KEY NOT NULL,
  user_id TEXT NOT NULL,
  year INTEGER NOT NULL,
  month INTEGER NOT NULL,
  day INTEGER NOT NULL,
  start_hour INTEGER NOT NULL,
  start_minute INTEGER NOT NULL,
  end_hour INTEGER NOT NULL,
  end_minute INTEGER NOT NULL,
  title VARCHAR(200),
  description TEXT NOT NULL
);

INSERT INTO calendarevents (user_id, year, month, day, start_hour, start_minute, end_hour, end_minute, title, description)
VALUES ('user', 2018, 06, 18, 15, 45, 16, 55, 'title', 'description')
