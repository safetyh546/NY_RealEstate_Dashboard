
// build caller function that calls all the pieces (charts)
function optionChanged(Borough) {  
    BuildLineChart(Borough)
  }
  
//load drop down list
//call optionchanged function for "All" boroughs for initial page load
d3.json("BoroughDropDown").then((data) =>{ 
    console.log('Building Borough Dropdown')
    console.log(data)

    var DropDownBorough =data;

    // console.log(names1)

    var dropdown = d3.select("#selDataset");


    //loop through names and add to dropdown
    DropDownBorough.forEach((item) => 
    {
        //append dropdown
        dropdown.append("option").text(item);
    });

    optionChanged("All")

});

 function BuildLineChart(Borough) {
    console.log(`Building line chart -${Borough}`)

    if (Borough == "All"){
        var Route = `SalesByMonth`;
        }
     else{
        var Route = `SalesByMonth/${Borough}`
     }    

     console.log(`Calling Flask route (${Route}) and buliding chart vars`)

    d3.json(Route).then((importedData) => {
        console.log(importedData)

        Month =importedData.map(row => row.Month)
        SaleCount = importedData.map(row => row.SaleCount)

        StartMonth = Month[0]
        Length = Month.length   
        EndMonth = Month[Length-1]
  
      var trace1 = {
        type: "scatter",
        mode: "lines",
        name: name,
        x: Month,
        y: SaleCount,
        // line: {
        //   color: "#17BECF",
        // },
      };
  
      var data = [trace1];
  
      var layout = {
        title: `Sales By Month - ${Borough}`,
        // title: `${stock} closing prices`,
        margin: {
            l: 200,
            r: 200,
            t: 100,
            b: 100
          },
        xaxis: {
          range: [StartMonth, EndMonth],
          type: "date",
          titlefont: {
            size: 20,
            color: 'rgb(107, 107, 107)'
          },
        },
        yaxis: {
          autorange: true,
          type: "linear",
        },
        showlegend: false,
      };
  
        Plotly.newPlot("plot", data, layout);
    });
 }

