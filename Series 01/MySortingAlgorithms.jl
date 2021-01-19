# Bogosort Algorithm

function bogosort!(data::AbstractVector)
    counter = 1
    println("Sort # $counter:\t$data")
    while !issorted(data)
        shuffle!(data)
        counter += 1
        println("Sort # $counter:\t$data")
    end
    return data
end

# Bubble Sort Algorithm

function bubblesort!(data::AbstractVector)
    len = length(data)
    for i in 1:(len - 1)
        println("Outer Loop $i:\t$data")
        for j in 1:(len - 1)
            if data[j] > data[j + 1]
                data[j], data[j + 1] = data[j + 1], data[j]
                println("  Inner Loop $j:\t$data")
            end
        end
    end
    return data
end

# Selection Sort Algorithm

function selectionsort!(data::AbstractVector)
    println("Initial:\t", data)
    len = length(data)
    if len < 2
        return data
    end
    for i in 1:(len - 1)
        localmin, index = findmin(data[(i + 1):end])
        if localmin < data[i]
            data[i], data[i + index] = localmin, data[i]
        end
        println("Sort # $i:\t", data)
    end
    return data
end

# Merge Sort Algorithm

function mergesort(data::AbstractVector)
    println("split data:\t", data)
    # base case
    if length(data) < 2
        println(" base case:\t", data)
        return data
    end
    # recursive case
    middle = length(data) ÷ 2
    leftside = mergesort(data[1:middle])
    rightside = mergesort(data[(middle + 1):end])
    merged = copy(data)
    index = rightindex = leftindex = 1
    while leftindex <= length(leftside) && rightindex <= length(rightside)
        if leftside[leftindex] <= rightside[rightindex]
            merged[index] = leftside[leftindex]
            leftindex += 1
        else
            merged[index] = rightside[rightindex]
            rightindex += 1
        end
        index += 1
    end
    if leftindex <= length(leftside)
        merged[index:end] = leftside[leftindex:end]
    else
        merged[index:end] = rightside[rightindex:end]
    end
    println("  mergesort:\t", merged)
    return merged
end
