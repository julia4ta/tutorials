# Tutorial 02x01: Iris Dataset

# Julia v1.5.3

# select packages

using VegaDatasets  # v2.1.0
using DataVoyager   # v1.0.0
using VegaLite      # v2.3.0

# load dataset

data = dataset("iris")

# display dataset

vscodedisplay(data)

# visualize dataset

v = Voyager(data)

# specify plot in DataVoyager before proceeding

# assign specified plot to a variable

p = v[]

# save plot

save("iris_voyager.png", p) # VegaLite required to save plot
save("iris_voyager.svg", p) # VegaLite required to save plot
