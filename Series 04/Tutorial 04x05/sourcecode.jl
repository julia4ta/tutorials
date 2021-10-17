using SQLite

clear() = run(`cmd /c cls`)

# create new database

db = SQLite.DB("entrylog.db")

# create new table in database

SQLite.execute(db, "CREATE TABLE IF NOT EXISTS user_entry
    (id INTEGER PRIMARY KEY, memo TEXT)
")

# app

function memoapp()
    while true
        println("What's on your mind?")
        println("(blank to exit)\n")
        input = readline()
        if input == ""
            break
        end
        SQLite.execute(db, "INSERT INTO user_entry (memo) VALUES ('$input')")
        println("\nThat's very interesting. Thanks for sharing.")
        println("(press any key to continue)")
        readline()
        clear()
    end
end
