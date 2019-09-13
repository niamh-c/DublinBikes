from flask import Flask, request, render_template
import pymysql
import json
import pandas as pd
from datetime import datetime
from cleanData import createDF
import os
from dotenv import load_dotenv

load_dotenv()
apiKey = os.getenv("JCD_API")
DB_host = os.getenv("HOST")
DB_database=os.getenv("DB")
DB_user=os.getenv("NAME")
DB_password=os.getenv("PASSWORD")

app = Flask(__name__)

@app.route('/getMarkerData', methods=['POST'])
def getMarkerData():
    name = request.form["name"]
    if "'" in name:
        name = name.replace("'", "''")
    db = pymysql.connect(host=DB_host, port=3306 , user=DB_user, passwd=DB_password, db=DB_database)
    sql = "SELECT name, avail_bikes, avail_bike_stands, bike_stands, status, last_update FROM latestInfo where name='%s'" % name
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    data = cursor.fetchone()
    return "#Name: "+ str(data[0]) + "#Available Bikes: "  + str(data[1]) + "#Available bike Stands: " + str(data[2]) + "#Bike Stands: " + str(data[3]) + "#Status: " + str(data[4]) + "#"+str(data[5])

@app.route('/histData', methods=['POST'])
def histData():
    now = datetime.now()
    date = now.weekday()
    name = request.form["name"]
    if "'" in name:
        name = name.replace("'", "''")
    sql = "select number, bike_stands from latestInfo where name = '"+name+"'"
    db = pymysql.connect(host=DB_host, port=3306 , user=DB_user, passwd=DB_password, db=DB_database)
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    myData = cursor.fetchall()
    number = myData[0][0]
    bikes = myData[0][1]
    filename = os.path.join(app.root_path,'dataAnalytics', 'meansforgraph.csv')
    data = pd.read_csv(filename)
    data = data[data.station == number]
    data = data[data.day == date]
    timeMeanData = []
    timeMeanData.append(data['time'].tolist())
    timeMeanData.append(data['mean'].tolist())
    timeMeanData.append(bikes)
    return json.dumps(timeMeanData)

@app.route('/markers', methods=['POST'])
def markers():
    sql = "SELECT number, name, address, latitude, longitude, avail_bikes, banking,status from latestInfo"
    db = pymysql.connect(host=DB_host, port=3306 , user=DB_user, passwd=DB_password, db=DB_database)
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    data = cursor.fetchall()
    return json.dumps(data)

@app.route('/toggleMarkers', methods=['POST'])
def toggleMarkers():
    toggle1 = request.form["toggle1"]
    toggle2 = request.form["toggle2"]
    sql = "SELECT avail_bike_stands, name, address, latitude, longitude, avail_bikes, banking,status from latestInfo where avail_bikes "+toggle1+" and avail_bike_stands "+toggle2
    db = pymysql.connect(host=DB_host, port=3306 , user=DB_user, passwd=DB_password, db=DB_database)
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    data = cursor.fetchall()
    return json.dumps(data)

@app.route('/stationLoc', methods=['POST'])
def stationLoc():
    name = request.form['name']
    if "'" in name:
        name = name.replace("'", "''")
    sql = "SELECT name, latitude, longitude from latestInfo where name ='"+name+"'"
    db = pymysql.connect(host=DB_host, port=3306 , user=DB_user, passwd=DB_password, db=DB_database)
    cursor = db.cursor()
    cursor.execute(sql)
    db.commit()
    data = cursor.fetchone()
    return str(data[1]) + "," + str(data[2])


@app.route('/predictions', methods=['POST'])
def predictions():
    name = request.form['name']
    date = request.form['date']
    time = request.form['time']
    if name == "Choose a Station":
        return "NONESTATION"
    elif time == "":
        return "NONETIME"
    else:
        result = createDF(name, date, time)
        return (result)


@app.route('/')
def index():
    return render_template('index.html')

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000,debug=True)
    #app.run(host='127.0.0.1', port=5000,debug=True)
