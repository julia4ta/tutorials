# Tutorial 02x08: DataFrames Part 3

# Julia v1.5.3

#=
    Packages used in this tutorial:
        CSV v0.8.3
        DataFrames v0.22.5
        DataFramesMeta v0.6.0
        Gadfly v1.3.1
        HTTP v0.9.5
        PrettyTables v0.11.1
=#

# Gadfly citation: https://doi.org/10.5281/zenodo.4101204

################################################################################



################################################################################
# SaveHTML.jl
################################################################################

# hack to save Table as HTML file

using PrettyTables

function savehtml(filename, data)
    open("$filename.html", "w") do f
        pretty_table(f, data, backend = :html)
    end
end

################################################################################
# HTTP
################################################################################

# download 2018-2019 population data from GitHub

using CSV, HTTP, DataFrames

url1 = "https://raw.githubusercontent.com/julia4ta/tutorials/master/Series%2002/Files/mydf.csv"

mydf_url = DataFrame(CSV.File(HTTP.get(url1).body))

savehtml("mydf_url", mydf_url)
CSV.write("mydf_url.csv", mydf_url)

# donwload 2019 gdp data from GitHub

url2 = "https://raw.githubusercontent.com/julia4ta/tutorials/master/Series%2002/Files/gdp_by_country_un.csv"

df_gdp = DataFrame(CSV.File(HTTP.get(url2).body))

savehtml("df_gdp", df_gdp)
CSV.write("df_gdp.csv", df_gdp)

################################################################################
# DataFrames
################################################################################

# outer join (include all countries)

df_outer = outerjoin(mydf_url, df_gdp, on = :country)
savehtml("df_outer", df_outer)

# inner join (keep only common countries)

df_inner = innerjoin(mydf_url, df_gdp, on = :country)
savehtml("df_inner", df_inner)

# convert gdp from millions to billions

df_inner.gdp = round.(df_inner.gdp ./ 1000, digits = 3)
savehtml("df_inner", df_inner)

# add column showing gdp per capita in thousands

df_inner.gdppc = round.(df_inner.gdp ./ df_inner.my19, digits = 3)
savehtml("df_inner", df_inner)

################################################################################
# DataFramesMeta
################################################################################

# Southern Asia Subregion countries using filter() from Julia Base

df_sa_base = filter(:subregion => x -> x == "Southern Asia", df_inner)
savehtml("df_sa_base", df_sa_base)

using DataFramesMeta

# Southern Asia Subregion countries using @where from DataFramesMeta

df_sa_dfm = @where(df_inner, :subregion .== "Southern Asia")
savehtml("df_sa_dfm", df_sa_dfm)

# multiple filters using @where macro

df_multi_filters = @where(df_inner,
    .|(:subregion .== "Southern Asia", :subregion .== "Northern America"),
    .&(:my19 .< 1, :gdppc .> 10)
)
savehtml("df_multi_filters", df_multi_filters)

# group, combine & calculate all in 1 step using @by macro

df_by_r = @by(df_inner, :region,
    my18_sum = sum(:my18),
    my19_sum = sum(:my19),
    mydelta_sum = sum(:mydelta),
    mypct_c = round.(sum(:mydelta) ./ sum(:my18) .* 100, digits = 2),
    my100_c = round.(sum(:my19) ./ sum(df_inner.my19) .* 100, digits = 2),
    gdp_sum = sum(:gdp),
    gdppc_c = round.(sum(:gdp) ./ sum(:my19), digits = 3)
)
savehtml("df_by_r", df_by_r)

# copy and paste code to summarize data by subregion

df_by_s = @by(df_inner, :subregion,
    region_unique = unique(:region),
    my18_sum = sum(:my18),
    my19_sum = sum(:my19),
    mydelta_sum = sum(:mydelta),
    mypct_c = round.(sum(:mydelta) ./ sum(:my18) .* 100, digits = 2),
    my100_c = round.(sum(:my19) ./ sum(df_inner.my19) .* 100, digits = 2),
    gdp_sum = sum(:gdp),
    gdppc_c = round.(sum(:gdp) ./ sum(:my19), digits = 3)
)
savehtml("df_by_s", df_by_s)

################################################################################
# Gadfly
################################################################################

using Gadfly

set_default_plot_size(16cm, 9cm)

# 1. bar plot by region

df_by_r = sort!(df_by_r, :my19_sum)

p = plot(df_by_r,
    x = :my19_sum,
    y = :region,
    color = :region,
    Geom.bar(orientation = :horizontal),
    Guide.xlabel("Population (mils)"),
    Guide.ylabel("Region"),
    Guide.title("2019 Population by Region"),
    Guide.colorkey(title = "Region"),
    Scale.x_continuous(format = :plain),
    Theme(
        background_color = "white",
        bar_spacing = 1mm
    )
)

# how to save plot

img = SVG("p_bar_region.svg", 16cm, 9cm)
draw(img, p)

# 2. bar plot by subregion

df_by_s = sort!(df_by_s, :my19_sum)

p = plot(df_by_s,
    x = :my19_sum,
    y = :subregion,
    color = :region_unique,
    Geom.bar(orientation = :horizontal),
    Guide.xlabel("Population (mils)"),
    Guide.ylabel("Subregion"),
    Guide.title("2019 Population by Subregion"),
    Guide.colorkey(title = "Region"),
    Scale.x_continuous(format = :plain),
    Theme(
        background_color = "white",
        bar_spacing = 1mm
    )
)

img = SVG("p_bar_subregion.svg", 16cm, 9cm)
draw(img, p)

# 3. point (scatter) plot by country

df_sub100 = @where(df_inner, :my19 .< 100)

p = plot(df_sub100,
    x = :my19,
    y = :mypct,
    color = :region,
    Geom.point,
    Guide.xlabel("Population (mils)"),
    Guide.ylabel("Growth Rate (%)"),
    Guide.title("2019 Population vs Growth Rate (sub 100 mil)"),
    Guide.colorkey(title = "Region"),
    Theme(background_color = "white")
)

img = SVG("p_point_country.svg", 16cm, 9cm)
draw(img, p)

# 4. beeswarm plot by region

p = plot(df_sub100,
    x = :region,
    y = :my19,
    color = :region,
    Geom.beeswarm,
    Guide.xlabel("Region"),
    Guide.ylabel("Population (mils)"),
    Guide.title("2019 Population Beeswarm by Region (sub 100 mil)"),
    Guide.colorkey(title = "Region"),
    Scale.y_continuous(format = :plain),
    Theme(background_color = "white")
)

img = SVG("p_beeswarm_region.svg", 16cm, 9cm)
draw(img, p)

# 5. box plot by region

p = plot(df_sub100,
    x = :region,
    y = :my19,
    color = :region,
    Geom.boxplot,
    Guide.xlabel("Region"),
    Guide.ylabel("Population (mils)"),
    Guide.title("2019 Population Boxplot by Region (sub 100 mil)"),
    Guide.colorkey(title = "Region"),
    Scale.y_continuous(format = :plain),
    Theme(background_color = "white")
)

img = SVG("p_boxplot_region.svg", 16cm, 9cm)
draw(img, p)

# 6. density plot by region

df_sub100_o = @where(df_sub100, :region .!= "Oceania")

p = plot(df_sub100_o,
    x = :my19,
    color = :region,
    Geom.density,
    Guide.xlabel("Population (mils)"),
    Guide.ylabel("Density"),
    Guide.title("2019 Population Density be Region (sub 100 mil ex Oceania)"),
    Guide.colorkey(title = "Region"),
    Scale.x_continuous(format = :plain),
    Theme(background_color = "white")
)

img = SVG("p_density_region.svg", 16cm, 9cm)
draw(img, p)

# 7. violin plot by region

p = plot(df_inner,
    x = :region,
    y = :gdppc,
    color = :region,
    Geom.violin,
    Guide.xlabel("Region"),
    Guide.ylabel(
        "GDP per Capita (dollars in 000s)",
        orientation = :vertical
    ),
    Guide.title("2019 GDP per Capita by Region"),
    Guide.colorkey(title = "Region"),
    Scale.y_continuous(format = :plain),
    Coord.cartesian(ymin = -25, ymax = 75),
    Theme(background_color = "white")
)

img = SVG("p_violin_region.svg", 16cm, 9cm)
draw(img, p)
