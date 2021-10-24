# obtain Query Data From SQLite database

using SQLite

db = SQLite.DB("Chinook_Sqlite.sqlite")

q = DBInterface.execute(db,
    "
        SELECT
            TrackId,
            Genre.Name AS Genre,
            Artist.Name AS Artist,
            Album.Title AS Album,
            Track.Name AS Track
        FROM
            Track
        INNER JOIN
            Artist ON Artist.ArtistId = Album.ArtistId,
            Album ON Album.AlbumId = Track.AlbumId,
            Genre ON Genre.GenreId = Track.GenreId
        ;    
    "
)

# load Query Data into Table

using TypedTables

t = Table(q)

# load Table into vscodedisplay()

vscodedisplay(t)

# load Table into pretty_table()

using PrettyTables

pretty_table(t; header_crayon = crayon"yellow bold")

# load Table into DataFrame()

using DataFrames

df = DataFrame(t)

# convert DataFrame into Array()

a = Array(df)
