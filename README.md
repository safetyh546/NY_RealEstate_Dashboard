# Group Project Members
1) Juan Rodriguez https://github.com/juanmarodri<br />
2) Isaiah Peek https://github.com/ipeek-cpu <br />
3) Maxbooz Homidas https://github.com/safetyh546 <br />

##  NYC Real Estate Sales Dashboard
1) The dashboard is powered by a PostgresSQL Database, Flask API, javascript files using plotly and d3/jquery libraries, and HTML/CSS front end pages
2) The data visualized in this dashboard originally came from the Kaggle website which had a concatenated and cleaned-up version of the New York City Department of Finance’s Rolling Real Estate Sales dataset. It contained real estate sales data for September 2016 through August 2017. The data had over 80 thousand rows. We limited our analysis to only the real estate sale price range of $500,000-$800,000. The resulting data in that price range had several rows where the square feet listed was 0 or not provided. We excluded such rows when looking at the price per square feet analysis.<br />

## Files used to create the dashboard
1) app.py - Flask App python file that serves the data to each page<br />
2) templates\Index.html - home page html<br />
3) templates\Visual1.html - html that calls Visual1Plots.js to make a filterable line chart with sales by month<br />
4) templates\Visual2.html - html that calls Visual2Plost.js to make the sales by borough bar chart<br />
5) templates\Visual3.html - html that calls Visual3Plost.js to make the Avg Price Per Square Foot bubble chart<br />
6) templates\DataPage.html - html that shows details about the kaggle dataset and allows you to dowload the csv file<br />
7) static\js - folder containing all the javascript files (Visual1Plost.js, Visual2Plosts.js, Visual3Plost.js)<br />
8) static\images - folder containing all the images for the html files<br />
9) static\css - folder containing css files for the html files<br />
10) Resources\Data - .sql files used to create postgresSQL tables and the csv of datasets<br />

## Data Analysis Questions Researched
1) When are most sales happening in NYC?  Visualization 1 sought to answher this with a line chart showing by Sales By Month.  This visual is filterable by borough<br />
2) Where are most sales occurring in NYC?  Visualization 2 is a barchart of sales by borough.  It shows Queens has highest sale count.<br />
3) How much property can you get for your money in NYC?  Visualization 3 shows Price per square feet per borough.  Queens again has the highest price per square foot.<br />

## Conclusions
1) When selling in NYC, highest frequency will be in summer<br />
2) If buying, fewer sales occur in colder months but prices may be lower due to lower demand<br />
3) Based on the data we have, Queens has the highest frequency of sales but it's alsmot the most expensive per square foot<br />

## Next steps if we had more time
1) Create a page with a map of the property addresses<br />
2) Could also use the map selection to choose a bureau and filter plotly charts<br />