# dictionary

# construct dictionary

dog = Dict(
    "name" => :eggdog,
    :age => 3,
    23 => "egg-dog mix"
)

# access value using key

dog["name"]

dog[:age]

dog[23]

# mutate value using key

dog["name"] = "Doggo"

dog[:age] = [1 2 3]

dog[23] = :breed

dog

# add new key-value pair

dog[:email] = "doggo@doggo.doggo"

dog

# remove key-value pair

pop!(dog, 23)

dog
