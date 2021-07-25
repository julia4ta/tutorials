# Tutorial 03x11: Web Scraping

# Julia v1.6.2

#= 
    Packages used in this tutorial:
        Cascadia v1.0.1
        Gumbo v0.8.0
        HTTP v0.9.12
=#

########################################
# Ex1. Scrape HTML table and convert to CSV file (small table)
########################################

# get HTML

using HTTP

url = "https://dabblingdoggo.github.io/mysite3/doggo/data.html"

r = HTTP.get(url)

# parse HTML

using Gumbo

h = parsehtml(String(r.body))

# head vs body

h.root[1]

h.root[2]

body = h.root[2]

body[1]

body[2]

body[3]

body[4]

body[4][1]

body[4][1][1]

table = body[4][1][1]

table.children

nrows = length(table.children)

# identify pattern for rows and columns

table[1]

table[2]

table[3]

header = table[1]

header.children

ncols = length(header.children)

table[1][1]

table[1][2]

table[1][3]

table[1][1][1]

table[1][1][1].text

# pattern is table[row][col][1].text

vector = String[]

for row in 1:nrows
    for col in 1:ncols
        push!(vector, table[row][col][1].text)
    end
end

vector

# reshape column vector

matrix = reshape(vector, (4, 4))

p_matrix = permutedims(matrix)

# save CSV file

using DelimitedFiles

writedlm("client-list.csv", p_matrix, ',')

########################################
# Ex2. Scrape HTML table and convert to CSV file (larger table)
########################################

# get HTML

using HTTP

url = "https://dabblingdoggo.github.io/mysite11/"

r = HTTP.get(url)

# parse HTML

using Gumbo

h = parsehtml(String(r.body))

body = h.root[2]

# find table element in HTML body

body[1]

body[1].children

body[1][38]

body[1][38][1]

table = body[1][38][1]

nrows = length(table.children)

# identify pattern for rows and columns

table[1]

table[2]

table[3]

header = table[1]

ncols = length(header.children)

table[1][1]

table[1][2]

table[1][3]

table[1][1][1]

table[1][1][1].text

# pattern is table[row][col][1].text

# scrape table into column vector

vector = String[]

for row in 1:nrows
    for col in 1:ncols
        push!(vector, table[row][col][1].text)
    end
end

vector

# reshape column vector

matrix = reshape(vector, (ncols, nrows))

p_matrix = permutedims(matrix)

# save CSV file

using DelimitedFiles

writedlm("world-population.csv", p_matrix, ',')

########################################
# Ex3. Scrape non-table data using Gumbo and convert to CSV file
########################################

# get HTML

using HTTP

url = "https://dabblingdoggo.github.io/mysite3/doggo/about.html"

r = HTTP.get(url)

# parse HTML

using Gumbo

h = parsehtml(String(r.body))

body = h.root[2]

body[4]

data = body[4]

data.children

nrows = length(data.children)

# identify pattern

data[1]

data[2]

data[3]

data[1][1]

data[1][1][1]

data[1][1][2]

data[1][1][2][1]

data[1][1][2][1].text

# pattern is data[row][1][2][1].text

# scrape data into column vector

staff = String[]

for row in 1:nrows
    push!(staff, data[row][1][2][1].text)
end

staff

# split names and titles

staff2 = String["Name", "Title"]

for row in 1:nrows
    for col in 1:2
        push!(staff2, split(staff[row], ", ")[col])
    end
end

staff2

# reshape column vector

matrix = reshape(staff2, (2, 4))

p_matrix = permutedims(matrix)

# save CSV file

using DelimitedFiles

writedlm("staff-gumbo.csv", p_matrix, ',')

########################################
# Ex4. Scrape non-table data using Gumbo+Cascadia and convert to CSV file
########################################

# get HTML

using HTTP

url = "https://dabblingdoggo.github.io/mysite3/doggo/about.html"

r = HTTP.get(url)

# parse HTML

using Gumbo

h = parsehtml(String(r.body))

body = h.root[2]

# find label class selector in HTML body

using Cascadia

s = eachmatch(Selector(".label"), body)

# identify pattern

s[1]

s[2]

s[3]

s[1][1]

s[1][1].text

# pattern is s[row][1].text

# scrape data into column vector

nrows = length(s)

staff = String[]

for row in 1:nrows
    push!(staff, s[row][1].text)
end

staff

# split names and titles

staff2 = String["Name", "Title"]

for row in 1:nrows
    for col in 1:2
        push!(staff2, split(staff[row], ", ")[col])
    end
end

staff2

# reshape column vector

matrix = reshape(staff2, (2, 4))

p_matrix = permutedims(matrix)

# save CSV file

using DelimitedFiles

writedlm("staff-cascadia.csv", p_matrix, ',')

########################################
# Ex5. Scrape Wikipedia table using Gumbo+Cascadia and convert to CSV file
########################################

# get HTML

using HTTP

url = "https://en.wikipedia.org/wiki/ISO_3166-1"

r = HTTP.get(url)

# parse HTML

using Gumbo

h = parsehtml(String(r.body))

body = h.root[2]

# find class selector in HTML body

using Cascadia

eachmatch(Selector("table"), body)

s = eachmatch(Selector(".wikitable sortable"), body)

s = eachmatch(Selector(".wikitable.sortable"), body)

# identify pattern

s[1]

s[2]

s[2][1]

s[2][1].children

table = s[2][1]

nrows = length(table.children)

table[1]

table[2]

table[3]

# 1st index is the row

table[1][1]

table[1][2]

table[1][3]

# 2nd index is the col

# pattern is table[row][col]...

# countries

table[2][1][1]

table[2][1][2]

table[2][1][2][1]

table[2][1][2][1].text

# pattern appears to be table[row][col][2][1].text

table[3][1][2][1].text

table[3][1][2][1]

table[3][1][2][1][1].text

table[4][1][2][1].text

table[5][1][2][1].text

#=
    pattern for countries is either
    table[row][col][2][1].text or
    table[row][col][1][1][1].text
=#

countries = String[]

col = 1

for row in 2:nrows
    try
        push!(countries, table[row][col][2][1].text)
    catch
        push!(countries, table[row][col][2][1][1].text)
    end
end

countries

# alpha-2 code

table[2][2]
table[2][2][1]
table[2][2][1][1]
table[2][2][1][2]
table[2][2][1][2][1]
table[2][2][1][2][1].text

table[3][2][1][2][1].text
table[4][2][1][2][1].text

# pattern is table[row][col][1][2][1].text

alpha2 = String[]

col = 2

for row in 2:nrows
    push!(alpha2, table[row][col][1][2][1].text)
end

alpha2

# alpha-3 code

table[2][3]
table[2][3][1]
table[2][3][2]
table[2][3][2][1]
table[2][3][2][1].text

table[3][3][2][1].text
table[4][3][2][1].text

# pattern is table[row][col][2][1].text

alpha3 = String[]

col = 3

for row in 2:nrows
    push!(alpha3, table[row][col][2][1].text)
end

alpha3

# numeric code

table[2][4][2][1].text
table[3][4][2][1].text
table[4][4][2][1].text

# pattern is table[row][col][2][1].text

num_code = String[]

col = 4

for row in 2:nrows
    push!(num_code, table[row][col][2][1].text)
end

num_code

# subdivision code

table[2][5]
table[2][5][1]
table[2][5][1][1]
table[2][5][1][1].text

table[3][5][1][1].text
table[4][5][1][1].text

# pattern is table[row][col][1][1].text

sub_code = String[]

col = 5

for row in 2:nrows
    push!(sub_code, table[row][col][1][1].text)
end

sub_code

# independent

table[2][6]
table[2][6][1]
table[2][6][1].text

table[3][6][1].text
table[4][6][1].text

# pattern is table[row][col][1].text

rstrip(table[2][6][1].text)
rstrip(table[3][6][1].text)
rstrip(table[4][6][1].text)

independent = String[]

col = 6

for row in 2:nrows
    push!(independent, rstrip(table[row][col][1].text))
end

independent

# assemble data

data = [countries alpha2 alpha3 num_code sub_code independent]

# create header

header = ["countries" "alpha2" "alpha3" "num_code" "sub_code" "independent"]

# assemble matrix

matrix = [header; data]

# save CSV file

using DelimitedFiles

writedlm("country-codes.csv", matrix, ',')
