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

# convert Query Data into DataFrame()

using DataFrames

df = DataFrame(q)

# convert DataFrame into Array()

a = Array(df)

# create GTK GUI for Query Data

using Gtk

# create List Store

ls = GtkListStore(Int, String, String, String, String)

for i in 1:size(a)[1]
    push!(ls, Tuple(a[i, :]))
end

# create List View
tv = GtkTreeView(GtkTreeModel(ls))

rTxt = GtkCellRendererText()

c1 = GtkTreeViewColumn("TrackId", rTxt, Dict([("text", 0)]))
c2 = GtkTreeViewColumn("Genre", rTxt, Dict([("text", 1)]))
c3 = GtkTreeViewColumn("Artist", rTxt, Dict([("text", 2)]))
c4 = GtkTreeViewColumn("Album", rTxt, Dict([("text", 3)]))
c5 = GtkTreeViewColumn("Track", rTxt, Dict([("text", 4)]))

push!(tv, c1, c2, c3, c4, c5)

# create GUI

win = GtkWindow("Doggo Display", 1280, 720)

s_win = GtkScrolledWindow(tv)

push!(win, s_win)

# display GUI

showall(win)

# make columns resizable

cols = [c1, c2, c3, c4, c5]

for c in cols
    GAccessor.resizable(c, true)
end

# make columns sortable

for (i, c) in enumerate(cols)
    GAccessor.sort_column_id(c, i - 1)
end

# make columns reorderable

for (i, c) in enumerate(cols)
    GAccessor.reorderable(c, i)
end
