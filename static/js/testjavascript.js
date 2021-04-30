console.log("hello")

d3.json("http://127.0.0.1:5000/PricePerSquareFoot")
    .then(function(data){
        console.log(data)
        var month =  data[0]
        console.log(month)
   
    
    })
