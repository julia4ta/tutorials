// data source

const url = "https://raw.githubusercontent.com/julia4ta/tutorials/master/Series%2002/Files/population_by_year.csv";

// getData function

async function getData() {

    // Part 1: Get CSV

    // fetch data
    const response = await fetch(url);
    // process data
    const rawData = await response.text();
    // publish data
    document.getElementById("csv").innerHTML = rawData;

    // developer info
    console.log(rawData);
    console.log("rawData type: " + typeof rawData);



    // Part 2: CSV to JSON
    // credit: Stack Overflow User "Paath" on 2016-05-07

    // initialize variables
    let arrayOne = rawData.split("\r\n");
    let header = arrayOne[0].split(",");
    let noOfRow = arrayOne.length;
    let noOfCol = header.length;
    let jsonData = [];
    let i = 0;
    let j = 0;

    // for loop (rows)
    for (i = 1; i < noOfRow - 1; i++) {
        let obj = {};
        let myNewLine = arrayOne[i].split(",");
        // nested for loop (columns)
        for (j = 0; j < noOfCol; j++) {
            obj[header[j]] = myNewLine[j];
        };
        // generate JSON
        jsonData.push(obj);
    };

    // publish data
    document.getElementById("json").innerHTML = jsonData;

    // developer info
    console.log(jsonData);
    console.table(jsonData);
    console.log("jsonData type: " + typeof jsonData);

    // Part 3: JSON to HTML Table
    // credit: Stack Overflow User "ray hatfield" on 2015-05-26

    // initialize variables
    let children = jsonData;
    let table = document.createElement("table");

    // function to generate table header row
    function addHeaders(table, keys) {
        let row = table.insertRow();
        for (i = 0; i < keys.length; i++) {
            let cell = row.insertCell();
            cell.appendChild(document.createTextNode(keys[i]));
        }
    }

    // generate table
    for (i = 0; i < children.length; i++) {
        let child = children[i];
        // generate header row
        if (i === 0) {
            addHeaders(table, Object.keys(child));
        }
        // generate data rows
        let row = table.insertRow();
        Object.keys(child).forEach(function (k) {
            let cell = row.insertCell();
            cell.appendChild(document.createTextNode(child[k]));
        })
    }

    // publish table
    document.getElementById("container").appendChild(table);

    // developer info
    console.log("HTML table type: " + typeof table);



    // Part 4: Plot Data

    // generate array for x-axis (years)

    let years = [];

    for (i in jsonData) {
        let item = jsonData[i];
        years.push(item.Year);
    }

    // generate array for y-axis (world population)

    let population = [];

    for (i in jsonData) {
        let item = jsonData[i];
        population.push(item.World);
    }

    // newPlot() arguments

    let p = document.getElementById("myPlot");

    let plotData = [
        {
            x: years,
            y: population
        }
    ];

    let layout = {
        title: "World Population by Year",
        xaxis: { title: "Year" },
        yaxis: { title: "Population (billions)" }
    };

    // generate plot
    Plotly.newPlot(p, plotData, layout);

    // developer info
    console.log(years);
    console.log(population);
    console.log(Plotly.newPlot(p, plotData, layout));
    console.log("plot type: " + typeof Plotly.newPlot(p, plotData, layout));


}

// call function

getData();
