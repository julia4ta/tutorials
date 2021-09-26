using DataVoyager, VegaDatasets, VegaLite

data = dataset("iris")

function voyagerapp()
    Voyager(data)
    while true
        println("(hit Enter to close app)")
        input = readline()
        if input == ""
            break
        end
    end
end
