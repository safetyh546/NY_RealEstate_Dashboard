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
@app.route("/Index")
def Index():
    return render_template("Index.html")

@app.route("/Visual1")
def Visual1():
    return render_template("Visual1.html")

@app.route("/Visual2")
def Visual2():
    return render_template("Visual2.html")

@app.route("/Visual3")
def Visual3():
    return render_template("Visual3.html")

@app.route("/DataPage")
def DataPage():
    return render_template("DataPage.html")

@app.route("/BoroughDropDown")
#return a list of dictionaries with Borough name and Sale Count
def BoroughDropDown():
    session = Session(engine)
    Borough = session.query(sales.borough_name).group_by(sales.borough_name).order_by(sales.borough_name).all()
    Borough_list = []
    Borough_list.append("All")
    for b in Borough:
        Borough_list.append(b[0])
    session.close()  

    return jsonify(Borough_list)


@app.route("/Sales")
#return a list of dictionaries with Borough name and Sale Count
def SaleCount():
    session = Session(engine)
    SaleCount = session.query(sales.borough_name,func.count(sales.sale_id)).group_by(sales.borough_name).order_by(desc(func.count(sales.sale_id))).all()
    Borough_Dict_list = []
    for b,ct in SaleCount:
        SaleDict = {}
        SaleDict["Borough"] = b
        SaleDict["SaleCount"] = ct
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
        MonthDict["SaleCount"] = ct
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
        MonthBoroughDict["SaleCount"] = ct1
        ByMonthBorough_Dict_list.append(MonthBoroughDict)
    
    session.close()  
    return jsonify(ByMonthBorough_Dict_list)  

@app.route("/PricePerSquareFoot")
#return a list of dictionaries with Month and Sale Count
def PricePerSqFt():
    session = Session(engine)
    PricePerSqFt = session.query(sales.borough_name,func.min(sales.sale_price),func.count(sales.sale_id),func.sum(sales.price_per_gross_square_foot)).filter(sales.gross_square_feet > "0").group_by(sales.borough_name).all()
    PricePerSqFt_Dict_list = []
    MonthList = []
    PPSList = []
    for b,m,c,s in PricePerSqFt:
        MonthPPSDict = {}
        MonthPPSDict["Borough"] = b
        MonthPPSDict["SaleCount"] = c
        MonthPPSDict["AvgPricePerSquareFoot"] = round(float(s/c),2)
        PricePerSqFt_Dict_list.append(MonthPPSDict)
        MonthList.append(m)
        PPSList.append(round(float(s/c),2))


    LineDict = {}
    LineDict["Month"] = MonthList
    LineDict["PricePerSquareFoot"] = PPSList
    session.close()  
    #return jsonify(PricePerSqFt)
    return jsonify(PricePerSqFt_Dict_list) 

if __name__ == "__main__":
    app.run(debug=True)        