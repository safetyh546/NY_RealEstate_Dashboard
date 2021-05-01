console.log("Maxbooz")
// d3.json("Sales").then((importedData) => {
//     console.log(importedData);
//     var data = importedData;

//     //data.sort(function(a, b) {
//         //return parseFloat(b.Salecount) - parseFloat(a.Salecount);
//       //});
    
//       data = data.slice(0, 10);

//   // Reverse the array due to Plotly's defaults
//   data = data.reverse();

//   // Trace1 for the Greek Data
//   var trace1 = {
//     x: data.map(row => row.Salecount),
//     y: data.map(row => row.Borough),
//     text: data.map(row => row.Borough),
//     name: "Borough",
//     type: "bar",
//     orientation: "h",
//     //width: 1.5,
  
//     // marker: {
//     //   color: 'rgb(158,202,225)',
//     //   opacity: 0.6,
//     //   line: {
//     //     color: 'rgb(8,48,107)',
//     //     width: 1.5
//     //   }
//     //}
//   };

//   // data
//   var chartData = [trace1];

//   // Apply the group bar mode to the layout
//   var layout = {
//     title: "NYC Sales By Burough",
//     margin: {
//       l: 500,
//       r: 500,
//       t: 100,
//       b: 100
//     },
//     xaxis: {
//       title: '# of Sales',
//       titlefont: {
//         size: 20,
//         color: 'rgb(107, 107, 107)'
//       },
//       yaxis: {tickfont: {
//         size: 24,
//         color: 'rgb(107, 107, 107)'
//       }},
//     }
   
//   };

//   // Render the plot to the div tag with id "plot"
//   Plotly.newPlot("plot", chartData, layout);
// });