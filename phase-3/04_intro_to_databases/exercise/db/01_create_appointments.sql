CREATE TABLE appointments(
  id INTEGER PRIMARY KEY,
  time DATETIME,
  doctor STRING,
  patient STRING,
  purpose STRING,
  notes STRING,
  canceled BOOLEAN DEFAULT FALSE
);