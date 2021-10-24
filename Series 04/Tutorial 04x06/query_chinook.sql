-- SQLite Cheat Sheet

-- how to select all rows from a table
-- SELECT * FROM Genre;
-- SELECT * FROM Artist;
-- SELECT * FROM Album;
-- SELECT * FROM Track;

-- how to select columns in a table
-- SELECT FirstName, LastName, Email FROM Customer;

-- how to sort data by a column
-- SELECT FirstName, LastName, Email FROM Customer ORDER BY FirstName ASC;
-- SELECT FirstName, LastName, Email FROM Customer ORDER BY LastName DESC;

-- how to filter data using a search condition
-- SELECT * FROM Album WHERE ArtistId = 1;

-- how to filter data using comparison operators
-- SELECT * FROM Album WHERE ArtistId >= 2 AND ArtistId <= 5;

-- how to filter data using logical operators
-- SELECT * FROM Album WHERE ArtistId BETWEEN 6 AND 10;

-- how to limit the number of rows to display
-- SELECT * FROM Track LIMIT 10;

-- how to filter data using pattern matching
-- SELECT * FROM Track WHERE Name LIKE 'b%';
-- SELECT * FROM Track WHERE Name LIKE '%dog%';

-- how to use INNER JOIN
-- SELECT * FROM Album INNER JOIN Artist ON Artist.ArtistId = Album.ArtistId;
-- SELECT * FROM Track INNER JOIN Album ON Album.AlbumId = Track.AlbumId;

-- SELECT
--     TrackId, Title, Name
-- FROM
--     Track
-- INNER JOIN
--     Album ON Album.AlbumId = Track.AlbumId
-- ;

-- how to use an alias
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
