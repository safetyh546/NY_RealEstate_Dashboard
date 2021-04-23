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
    # return render_template("index.html")
    return (
        f"Welcome to NYC Real Estate Sale Database API!<br/>"
        f"This API contains NYC sale data for sales between 9/1/2016 and 8/31/2017<br/>"
        f"Available Routes:<br/><br/>"
        f"/Sales <br/>This route will dispaly total sales by borough<br/><br/>"
    )

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

if __name__ == "__main__":
    app.run(debug=True)        