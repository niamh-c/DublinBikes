import requests
import json
import mysql.connector
import time
import os
from dotenv import load_dotenv

load_dotenv()
apiKey = os.getenv("JCD_API")
DB_host = os.getenv("HOST")
DB_database=os.getenv("DB")
DB_user=os.getenv("NAME")
DB_password=os.getenv("PASSWORD")

#infinite loop
while True:
    #get request from jcdecaux api
    try:
        r = requests.get("https://api.jcdecaux.com/vls/v1/stations?contract=Dublin&apiKey="+apiKey)
        request_json = r.json()
        r.raise_for_status()
    except requests.exceptions.HTTPError as err:
        file = open("errorLog.txt","a")
        file.write(str(err) + "\n")
        file.close()
        time.sleep(600)
        r = requests.get("https://api.jcdecaux.com/vls/v1/stations?contract=Dublin&apiKey="+apiKey)
        request_json = r.json()
    except requests.exceptions.Timeout as err:
        file = open("errorLog.txt","a")
        file.write(str(err) + "\n")
        file.close()
        # Maybe set up for a retry, or continue in a retry loop
        time.sleep(600)
        r = requests.get("https://api.jcdecaux.com/vls/v1/stations?contract=Dublin&apiKey="+apiKey)
        request_json = r.json()
    except requests.exceptions.TooManyRedirects as err:
        file = open("errorLog.txt","a")
        file.write(str(err) + "\n")
        file.close()
        # Tell the user their URL was bad and try a different one
        sys.exit(1)
    except requests.exceptions.RequestException as err:
        file = open("errorLog.txt","a")
        file.write(str(err) + "\n")
        file.close()
        # catastrophic error. bail.
        sys.exit(1)
    mydb = mysql.connector.connect(
        host=DB_host,
        port='3306',
        database=DB_database,
        user=DB_user,
        password=DB_password,
    )
    #a mySQL cursor is an object that uses mySQL connect to establish a remote
    #sql connection with a database. Built into the mysql.connector module
    cursor = mydb.cursor()
    #loop through all the json data
    for i in range(0, len(request_json)):
        number=request_json[i]['number']
        name = request_json[i]['name']
        available_bikes = request_json[i]['available_bikes']
        available_bike_stands = request_json[i]['available_bike_stands']
        bike_stands = request_json[i]['bike_stands']
        status = request_json[i]['status']
        banking = request_json[i]['banking']
        address = request_json[i]['address']
        longitude = request_json[i]['position']['lng']
        latitude = request_json[i]['position']['lat']
        last_upd = request_json[i]['last_update']/1000
        last_upd += 3600
        last_update = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(last_upd))

        add_data = ("INSERT IGNORE INTO dynamicData (number,name,avail_bikes, avail_bike_stands, bike_stands, status, last_update) VALUES (%s,%s,%s,%s,%s, %s, %s)", (number,name, available_bikes, available_bike_stands, bike_stands,status, last_update))
        cursor.execute(*add_data)
        mydb.commit()
        #update_info = ("INSERT INTO latestInfo (number,name,avail_bikes, avail_bike_stands, status, last_update, address, latitude, longitude, banking, bike_stands ) VALUES (%s,%s,%s,%s, %s, %s, %s, %s, %s, %s, %s)", (number,name, available_bikes, available_bike_stands,status, last_update, address, latitude, longitude, banking, bike_stands))
        update_info=("UPDATE latestInfo SET name=%s, avail_bikes=%s, avail_bike_stands=%s, status=%s, last_update=%s where number=%s", (name, available_bikes, available_bike_stands,status, last_update, number))
        cursor.execute(*update_info)
        #commit the sql request to the database
        mydb.commit()
    #close out our connections
    cursor.close()
    mydb.close()
    #sleep for 5 minutes, and then do it again!
    time.sleep(300)
