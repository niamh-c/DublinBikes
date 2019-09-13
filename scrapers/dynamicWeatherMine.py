import time
import mysql.connector
import json
import requests
import os
from dotenv import load_dotenv
load_dotenv()
city_id = "7778677"
api_key = os.getenv("WEATHER_API")
DB_host = os.getenv("HOST")
DB_database=os.getenv("DB")
DB_user=os.getenv("NAME")
DB_password=os.getenv("PASSWORD")
#infinite loop
while True:
    #get request from jcdecaux api
    #setup mySQL connection to RDS, provide it with necessary info
    mydb = mysql.connector.connect(
        host=DB_host,
        port='3306',
        database=DB_database,
        user=DB_user,
        password=DB_password,
    )
    #a mySQL cursor is an object that uses mySQL connect to establish a remote sql connection with a database. Built into the mysql.connector module
    cursor = mydb.cursor()
    #get all ther weather data from the API
    try:
        r = requests.get("http://api.openweathermap.org/data/2.5/weather?id="+city_id+"&APPID="+api_key)
        request_json = r.json()
        r.raise_for_status()
    except requests.exceptions.HTTPError as err:
        file = open("errorLog.txt","a")
        file.write(str(err) + "\n")
        file.close()
        time.sleep(600)
        r = requests.get("http://api.openweathermap.org/data/2.5/weather?id="+city_id+"&APPID="+api_key)
        request_json = r.json()
    except requests.exceptions.Timeout as err:
        file = open("errorLog.txt","a")
        file.write(str(err) + "\n")
        file.close()
        # Maybe set up for a retry, or continue in a retry loop
        time.sleep(600)
        r = requests.get("http://api.openweathermap.org/data/2.5/weather?id="+city_id+"&APPID="+api_key)
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
    request_json = r.json()
    last = request_json['dt']
    last_time = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(last))
    description = request_json['weather'][0]['description']
    main = request_json['weather'][0]['main']
    visibility = request_json['visibility']
    wind_speed = request_json['wind']['speed']
    #get weather temp and convert from kelvin to C
    temp = request_json['main']['temp'] - 273.15

    #Building our sql query. I've used the '%s' notation there so that I can use the variables I've created as the values I'm inserting
    add_data = ("INSERT INTO weather(temp, wind_speed, visibility, main, description, last_time) VALUES (%s,%s,%s,%s,%s, %s)", (temp, wind_speed, visibility, main, description, last_time))
    #Here we execute the SQL command. The * is there to tell SQL to not format any of the data, otherwise it tries to encode it and breaks the command.
    cursor.execute(*add_data)
    #commit the sql request to the database
    mydb.commit()
    #close out our connections
    cursor.close()
    mydb.close()
    #sleep for 5 minutes, and then do it again!
    time.sleep(300)
