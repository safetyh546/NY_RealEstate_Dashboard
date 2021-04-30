#################################################
# import dependencies
#################################################

from matplotlib import style
import matplotlib.pyplot as plt
from pandas import DataFrame
import pandas as pd
import numpy as np
import pandas as pd
import datetime as dt
import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func, desc, distinct
from flask import Flask, jsonify, render_template
from config import password

#################################################
# Database Setup
#################################################
# create engine 
engine = create_engine(f'postgresql://postgres:{password}@localhost:5432/nyc_db')
connection = engine.connect()

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save references to each table
sales = Base.classes.sales
#top_tags = Base.classes.top_tags

#################################################
# Flask Setup
#################################################
app = Flask(__name__)
app.config['JSON_SORT_KEYS'] = False

#################################################
# Flask Routes
#################################################
@app.route("/")
@app.route("/home")
def home():
    return render_template("Index.html")
    # return render_template("index.html")
    # return (
    #     f"Welcome to NYC Real Estate Sale Database API!<br/>"
    #     f"This API contains NYC sale data for sales between 9/1/2016 and 8/31/2017<br/>"
    #     f"Available Routes:<br/><br/>"
    #     f"/Sales <br/>This route will dispaly total sales by borough<br/><br/>"
    # )

@app.route("/Sales")
#return a list of dictionaries with Borough name and Sale Count
def SaleCount():
    session = Session(engine)
    SaleCount = session.query(sales.borough_name,func.count(sales.sale_id)).group_by(sales.borough_name).order_by(desc(func.count(sales.sale_id))).all()
    Borough_Dict_list = []
    for b,ct in SaleCount:
        SaleDict = {}
        SaleDict["Borough"] = b
        SaleDict["Sale count"] = ct
        Borough_Dict_list.append(SaleDict)
    session.close()  
    return jsonify(Borough_Dict_list)

@app.route("/SalesByMonth")
#return a list of dictionaries with Month and Sale Count
def SaleByMonth():
    session = Session(engine)
    SaleByMo = session.query(sales.sale_date_yyyymm,func.count(sales.sale_id)).group_by(sales.sale_date_yyyymm).order_by(sales.sale_date_yyyymm).all()
    ByMonth_Dict_list = []
    for m,ct in SaleByMo:
        MonthDict = {}
        MonthDict["Month"] = m
        MonthDict["Sale count"] = ct
        ByMonth_Dict_list.append(MonthDict)
    session.close()  
    return jsonify(ByMonth_Dict_list)    

@app.route("/SalesByMonth/<Borough>")
#return a list of dictionaries with Month and Sale Count for passed in borough
def SaleByMonthByBorough(Borough):
    session = Session(engine)
    SaleByMoByBorough = session.query(sales.sale_date_yyyymm,func.count(sales.sale_id)).filter(sales.borough_name == Borough).group_by(sales.sale_date_yyyymm).order_by(sales.sale_date_yyyymm).all()
    ByMonthBorough_Dict_list = []
    for mb,ct1 in SaleByMoByBorough:
        MonthBoroughDict = {}
        MonthBoroughDict["Month"] = mb
        MonthBoroughDict["Sale count"] = ct1
        ByMonthBorough_Dict_list.append(MonthBoroughDict)
    
    #Create the outermost dictionary
    #Set details to the list of dictionaries you created above InnerTagDictList
    final_dict = {}
    final_dict["Borough Name"] = Borough
    final_dict["details"] = ByMonthBorough_Dict_list
 
 
    session.close()  
    return jsonify(final_dict)  

@app.route("/PricePerSquareFoot")
#return a list of dictionaries with Month and Sale Count
def PricePerSqFt():
    session = Session(engine)
    PricePerSqFt = session.query(sales.sale_date_yyyymm,func.count(sales.sale_id),func.sum(sales.price_per_gross_square_foot)).filter(sales.gross_square_feet > "0").group_by(sales.sale_date_yyyymm).order_by(sales.sale_date_yyyymm).all()
    PricePerSqFt_Dict_list = []
    MonthList = []
    PPSList = []
    for m,c,s in PricePerSqFt:
        MonthPPSDict = {}
        MonthPPSDict["Month"] = m
        MonthPPSDict["Sale Count"] = c
        MonthPPSDict["Avg Price Per Square Foot"] = round(float(s/c),2)
        PricePerSqFt_Dict_list.append(MonthPPSDict)
        MonthList.append(m)
        PPSList.append(round(float(s/c),2))


    LineDict = {}
    LineDict["Month"] = MonthList
    LineDict["PricePerSquareFoot"] = PPSList
    session.close()  
    #return jsonify(PricePerSqFt)
    return jsonify(LineDict) 

if __name__ == "__main__":
    app.run(debug=True)        