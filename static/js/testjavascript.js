console.log("hello")

d3.json("http://127.0.0.1:5000/Sales")
    .then(function(data){
        console.log(data)
    })
