# Tutorial 02x13: Final Project:
#     Interactive Analytic Tool for the Reviewbrah Data Set

# Julia v1.6.0

#=
    Packages used in this tutorial:
        CSV v0.8.4
        DataFrames v0.22.7
        DataFramesMeta v0.6.0
        GLMakie v0.2.5
        PrettyTables v0.11.1
=#

# Makie.jl Citation: https://doi.org/10.5281/zenodo.4450294

################################################################################

################################################################################
# load packages
################################################################################

using Dates, Statistics

using CSV, DataFrames, DataFramesMeta, GLMakie, PrettyTables

include("saveHTML.jl")

################################################################################
# data wrangling
################################################################################

# assign Types to columns

mytypes = [
    String, String, String, String, String, String, String,
    Float64, Float64
]

# load data into DataFrame

df = DataFrame(CSV.File("reviewbrah.csv", types = mytypes))

# add index numbers

df.id = 1:nrow(df)

df = select!(df, :id, :)

# convert dataframe into HTML file

savehtml("reviewbrah", df)

# convert length column from String to minutes

mytimeformat = DateFormat("MM:SS")

len = Time.(df.length, mytimeformat)

min = minute.(len)

sec = second.(len)

df.length = min .+ sec ./ 60

savehtml("reviewbrah", df)

# convert date column from String to Date

mydateformat = DateFormat("m/d/y")

df.date = Date.(df.date, mydateformat) .+ Dates.Year(2000)

savehtml("reviewbrah", df)

# add column for year

df.year = year.(df.date)

savehtml("reviewbrah", df)

# descriptive analysis

df_describe = describe(df, :all)

savehtml("describe", df_describe)

# get list of unique years

unique_years = unique(df.year)

vscodedisplay(unique_years)

# get list of unique categories

unique_categories = unique(df.category)

vscodedisplay(unique_categories)

# get list of categories reviewed every year

# check to see if category reviewed in year

df_categories = @by(df, :category,
    in_2012 = in(2012, :year),
    in_2013 = in(2013, :year),
    in_2014 = in(2014, :year),
    in_2015 = in(2015, :year),
    in_2016 = in(2016, :year),
    in_2017 = in(2017, :year),
    in_2018 = in(2018, :year),
    in_2019 = in(2019, :year),
    in_2020 = in(2020, :year)
)

savehtml("df_categories", df_categories)

# add rows

df_cat_sum = @transform(df_categories, in_sum =
    sum.(eachrow(df_categories[:, 2:10]))
)

# only keep categories reviewed every year

df_cat_all_years = @where(df_cat_sum, :in_sum .== 9)

cat = df_cat_all_years[:, :category]

vscodedisplay(cat)

################################################################################
# Create Interactive Plot with Menus
################################################################################

# initialize plot

fig = Figure(resolution = (3840, 2160))

# add axis

ax1 = fig[1, 1] = Axis(fig,
    # borders
    aspect = 1.5,
    # title
    title = "Reviewbrah Interactive",
    titlegap = 48, titlesize = 60,
    # x-axis
    xlabel = "Metric", xlabelsize = 48,
    xgridwidth = 2, xticklabelsize = 36,
    xticks = LinearTicks(20), xticksize = 18,
    # y-axis
    ylabel = "Density", ylabelpadding = 30, ylabelsize = 48,
    ygridwidth = 2, yticklabelpad = 14,
    yticklabelsize = 36, yticks = LinearTicks(10), yticksize = 18,
    # set limits
    limits = (0, 20, 0, 0.5)
)

# set up menu for metrics

metrics = [:rating, :price, :length]

metricname = ["Rating (0 - 10)", "Price (US dollars)", "Length (minutes)"]

metricmenu = Menu(fig, options = zip(metricname, metrics), textsize = 30)

# set up menu for years

years = [9999, unique_years...]

yearname = ["All Years",
    "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"
]

yearmenu = Menu(fig, options = zip(yearname, years), textsize = 30)

# set up menu for categories

categoryname = ["All Categories", cat...]

categorymenu = Menu(fig, options = categoryname, textsize = 30)

# create menu grid

fig[1, 2] = vgrid!(
    Label(fig, "Metric:", textsize = 30, width = 500), metricmenu,
    Label(fig, "Year:", textsize = 30, width = 500), yearmenu,
    Label(fig, "Category:", textsize = 30, width = 500), categorymenu;
    tellheight = false, width = 650
)

# set up Nodes

mc = Node(metrics[1])

yr = Node(years[1])

ct = Node(categoryname[1])

# set up listener

m = @lift(
    if $ct .== "All Categories"
        if $yr .== 9999
            df[:, $mc]
        else
            @where(df, :year .== $yr)[:, $mc]
        end
    else
        if $yr .== 9999
            @where(df, :category .== $ct)[:, $mc]
        else
            @where(df, .&(:category .== $ct, :year .== $yr))[:, $mc]
        end
    end
)

# add density plot

den1 = density!(ax1, m,
    color = (:dodgerblue, 0.5), strokecolor = :black, strokewidth = 2
)

# add vlines for mean and standard deviations

avg = @lift(mean($m))

stdev = @lift(std($m))

line1 = vlines!(ax1, @lift([$avg - $stdev, $avg, $avg + $stdev]),
    color = :green, linewidth = 4, linestyle = :dash
)

# set up menu instructions

# for metrics

on(metricmenu.selection) do select
    mc[] = select
end

# for year

on(yearmenu.selection) do select
    yr[] = select
end

# for category

on(categorymenu.selection) do select
    ct[] = select
end

# save plot

save("reviewbrah.png", fig)
