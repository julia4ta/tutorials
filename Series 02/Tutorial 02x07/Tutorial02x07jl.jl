# Tutorial 02x07: DataFrames Part 2

# Julia v1.5.3

#=
    Packages used in this tutorial:
        CSV v0.8.3
        DataFrames v0.22.5
        PrettyTables v0.11.1
=#

################################################################################

################################################################################
# GitHub Tutorial
################################################################################

# hack to save Table as HTML file

using PrettyTables

function savehtml(filename, data)
    open("$filename.html", "w") do f
        pretty_table(f, data, backend = :html)
    end
end

################################################################################
# Construct DataFrame using tabular data from Wikipedia
################################################################################

using CSV, DataFrames

df = DataFrame(CSV.File("population.csv"))

# save DataFrame as HTML file

savehtml("population_original", df)

################################################################################
# Data Wrangling
################################################################################

# add index numbers (source: Kamiński)

df.id = 1:nrow(df)

df = select!(df, :id, :)

savehtml("population_working", df)

# change headers with a vector

headers = [
    :id, :country, :region, :subregion, :wiki18, :wiki19, :wikipct
]

rename!(df, headers)

savehtml("population_working", df)

# remove commas

df.wiki18nocomma = replace.(df.wiki18, "," => "")
df.wiki19nocomma = replace.(df.wiki19, "," => "")
savehtml("population_working", df)

# convert String to Int

df.wiki18Int = parse.(Int, df.wiki18nocomma)
df.wiki19Int = parse.(Int, df.wiki19nocomma)
savehtml("population_working", df)

# convert from "people" to "millions of people"

df.my18 = round.(df.wiki18Int ./ 10^6, digits = 3)
df.my19 = round.(df.wiki19Int ./ 10^6, digits = 3)
savehtml("population_working", df)

# add column showing year-over-year population change

df.mydelta = round.(df.my19 .- df.my18, digits = 3)
savehtml("population_working", df)

# add column showing year-over-year percent change

df.mypct = round.(
    ((df.wiki19Int .- df.wiki18Int) ./ df.wiki18Int) .* 100, digits = 2
)
savehtml("population_working", df)

# construct new df containing selected columns in selected order

myheaders = [
    :id, :region, :subregion, :country, :my18, :my19, :mydelta, :mypct
]

mydf = select(df, myheaders)

savehtml("mydf", mydf)

# construct new df containing last row of mydf

mydf_t = mydf[end, :]

mydf_t = DataFrame(mydf_t)

savehtml("mydf_t", mydf_t)

# delete last row of mydf

delete!(mydf, nrow(mydf))
savehtml("mydf", mydf)

################################################################################
# Descriptive Analysis
################################################################################

# describe mydf

mydf_d = describe(mydf)
savehtml("mydf_d", mydf_d)

# display all descriptive statistics

mydf_d = describe(mydf, :all)
savehtml("mydf_d", mydf_d)

# list unique regions

regions_u = unique(mydf.region)

vscodedisplay(regions_u)

# list unique subregions

subregions_u = unique(mydf.subregion)

vscodedisplay(subregions_u)

# sort by country

mydf = sort!(mydf, :country)
savehtml("mydf", mydf)

# sort by region, then by subregion, then by country

myorder = [:region, :subregion, :country]
mydf = sort!(mydf, myorder)
savehtml("mydf", mydf)

# add up population by country

my18_t = sum(mydf.my18)

my19_t = sum(mydf.my19)

mydelta_t = my19_t - my18_t

mypct_t = mydelta_t / my18_t * 100

# wiki totals

wiki18_t = mydf_t.my18[1]

wiki19_t = mydf_t.my19[1]

wikidelta_t = mydf_t.mydelta[1]

wikipct_t = mydf_t.mypct[1]

# compare calculations with wiki totals

my18_t - wiki18_t

my19_t - wiki19_t

mydelta_t - wikidelta_t

mypct_t - wikipct_t

# add column showing percent contribution

mydf.my100 = round.(
    mydf.my19 ./ sum(my19_t) .* 100, digits = 2
)
savehtml("mydf", mydf)

# verify new column adds to 100%

sum(mydf.my100)

################################################################################
# How to Group/Combine DataFrames
################################################################################

# group data by region

mygdf = groupby(mydf, :region)

# show mygdf in REPL

show(mygdf, allgroups = true)

# combine grouped data

mygdf_c = combine(mygdf,
    :my18 => sum,
    :my19 => sum,
    :mydelta => sum
)

# add percent columns

mygdf_c.mypct_c = round.(
    mygdf_c.mydelta_sum ./ mygdf_c.my18_sum .* 100, digits = 2
)

mygdf_c.my100_c = round.(
    mygdf_c.my19_sum ./ sum(mygdf_c.my19_sum) .* 100, digits = 2
)

savehtml("mygdf_c", mygdf_c)

# check totals

my18gdf_t = sum(mygdf_c.my18_sum)

my19gdf_t = sum(mygdf_c.my19_sum)

my18_t - my18gdf_t

my19_t - my19gdf_t

# sort to find fastest growing regions by population

mygdf_c = sort!(mygdf_c, :mydelta_sum, rev = true)
savehtml("fastest growing regions by population", mygdf_c)

# sort to find fastest growing regions by percentage

mygdf_c = sort!(mygdf_c, :mypct_c, rev = true)
savehtml("fastest growing regions by percentage", mygdf_c)

# sort to find largest contributors to world population by region

mygdf_c = sort!(mygdf_c, :my100_c, rev = true)
savehtml("largest population contributor by region", mygdf_c)

################################################################################
# group/combine data by subregion
################################################################################

# group data by subregion

mygdf_s = groupby(mydf, :subregion)

# show mygdf_s in REPL

show(mygdf_s, allgroups = true)

# combine grouped data

mygdf_s_c = combine(mygdf_s,
    :region => unique,
    :my18 => sum,
    :my19 => sum,
    :mydelta => sum
)

# add percent columns

mygdf_s_c.mypct_s = round.(
    mygdf_s_c.mydelta_sum ./ mygdf_s_c.my18_sum .* 100, digits = 2
)

mygdf_s_c.my100_s = round.(
    mygdf_s_c.my19_sum ./ sum(mygdf_s_c.my19_sum) .* 100, digits = 2
)

savehtml("mygdf_s_c", mygdf_s_c)

# check totals

my18gdf_s_t = sum(mygdf_s_c.my18_sum)

my19gdf_s_t = sum(mygdf_s_c.my19_sum)

my18_t - my18gdf_s_t

my19_t - my19gdf_s_t

# sort to find fastest growing subregions by population

mygdf_s_c = sort!(mygdf_s_c, :mydelta_sum, rev = true)
savehtml("fastest growing subregions by population", mygdf_s_c)

# sort to find fastest growing subregions by percentage

mygdf_s_c = sort!(mygdf_s_c, :mypct_s, rev = true)
savehtml("fastest growing subregions by percentage", mygdf_s_c)

# sort to find largest contributors to world population by subregion

mygdf_s_c = sort!(mygdf_s_c, :my100_s, rev = true)
savehtml("largest population contributor by subregion", mygdf_s_c)

# save csv files for all dataframes

CSV.write("mydf.csv", mydf)
CSV.write("mygdf_c.csv", mygdf_c)
CSV.write("mygdf_s_c.csv", mygdf_s_c)
