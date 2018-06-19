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
