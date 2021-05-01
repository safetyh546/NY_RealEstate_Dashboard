
d3.json("PricePerSquareFoot").then((importedData) => {

    console.log(importedData)

    Borough =importedData.map(row => row.Borough)
    PPS = importedData.map(row => row.AvgPricePerSquareFoot)

    console.log(Borough)

    console.log(PPS)
        //-------------------------------------------------------------------
        //bubble chart
        
        // //list all otu_IDs along x-axis
        // var xaxis = inputValueData[0].otu_ids;
        // console.log(xaxis);

        var bubbleChartData = 
            [{
                x: Borough,
                y: PPS,
                mode: 'markers',
                text: Borough,
                marker: 
                {
                size: PPS,
                color: Borough,
                colorscale: [[0, 'rgb(51, 70, 255)'], [1, 'rgb(66, 255, 51)']]  //0 color is bluish, 1 color is green from https://htmlcolorcodes.com/
                }
            }];
            
            var bubbleChartLayout = 
            {
                
                title: "Avg Price Per Square Foot",
                showlegend: false,
                height: 700,
                width: 1300,
                xaxis: {title: 'Borough'},
                yaxis: {title: '$ Per Square Foot'},
                opacity: 0.6
            };
            
        //     var guage_wfreq = data.metadata.filter(item => item.id === parseInt(SubjectID))[0].wfreq

            Plotly.newPlot('bubble',bubbleChartData, bubbleChartLayout)


})