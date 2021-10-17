using SQLite

# create new database

db = SQLite.DB("contactdata.db")

# create new table in database

SQLite.execute(db, "CREATE TABLE IF NOT EXISTS contacts
    (id INTEGER PRIMARY KEY, name TEXT, age INTEGER, breed TEXT, email TEXT)
")

# add rows to table

SQLite.execute(db, "INSERT INTO contacts (name, age, breed, email)
    VALUES ('eggdog', 2, 'egg-dog mix', 'doggo@doggo.doggo')
")

SQLite.execute(db, "INSERT INTO contacts (name, age, breed, email)
    VALUES ('bongocat', 3, 'catto', 'catto@catto.catto')
")

SQLite.execute(db, "INSERT INTO contacts (name, age, breed, email)
    VALUES ('pabu', 1, 'red panda', 'panda@panda.panda')
")
