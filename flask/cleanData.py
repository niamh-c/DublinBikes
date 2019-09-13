import json
import pandas as pd
import pickle
import requests
from datetime import datetime
from string import ascii_letters
from sklearn.preprocessing import MinMaxScaler
from flask import Flask
import os
app = Flask(__name__)

def createDF(name, date, time):
    filename = os.path.join(app.root_path,'dataAnalytics', 'weather_dict')
    WEATHER=pickle.load(open(filename,"rb"))
    filename = os.path.join(app.root_path,'dataAnalytics', 'rush_hr_dicts')
    RUSH=pickle.load(open(filename,"rb"))
    filename = os.path.join(app.root_path,'dataAnalytics', 'time_dict')
    TIME=pickle.load(open(filename,"rb"))

    # Define a prefix for easy update of file locations
    filePrefix = "dataAnalytics"

    #convert inputted data appropriately
    if "/" in date:
        date = date.replace("/","-")
    day = datetime.strptime(date, '%m-%d-%Y')
    day = day.weekday()
    name=name.upper()


    #Holds the times for prediction charts
    time=TIME[int(time)]
    temp=(time)
    timeL=[temp]


    #so as not to switch days when predicting times
    count=0
    while count<125 and temp<2375:
        temp+=25
        timeL+=temp,
        count+=1
    temp=(time)
    count=0
    while count<125 and temp>0:
        temp-=25
        timeL+=temp,
        count+=1
    timeL.sort()

    #creates the new dataframe for predictions
    dt = pd.DataFrame(data={'time':timeL}, dtype='int64')
    #converts name to number
    filename = os.path.join(app.root_path,'static', 'NameNumberbanking.csv')
    numbers = pd.read_csv(filename, usecols=['number', 'name'])
    stationnumber=int(numbers.loc[numbers.name==name]['number'])

    #calls the weather API to get forecast
    requestData=requests.get('https://api.openweathermap.org/data/2.5/forecast?id=7778677&APPID=815f47098ae152b7dd0608932e89290d')
    data = json.loads(requestData.content.decode('utf-8'))

    #Unpacks and formats weather
    df=pd.DataFrame.from_dict(data['list'])
    #df=df.drop(['clouds', 'rain', 'sys', 'dt'],1)
    df['dt_txt'] = df['dt_txt'].astype('datetime64[ns]')
    df['day']=df['dt_txt'].dt.dayofweek
    df=df.loc[(df.day==day)]
    df['time']=df["dt_txt"].dt.strftime('%H%M').astype("int64")

    #Merges weather and station data and cleans it
    df=pd.merge_asof(dt, df, on='time', direction='nearest')
    for i in list(df.index):
        df.at[i, 'weather']=df['weather'][i][0]['description']
        df.at[i, 'main']=(float(df.main[i]['temp'])-273.15)
        df.at[i, 'wind']=df.wind[i]['speed']
    df['weather']=df['weather'].replace(WEATHER)
    df=df.rename(index=str, columns={"main": "temp", "wind":"wind_speed"})
    df=df.drop("dt_txt", 1);
    df[['day','time','weather','temp','wind_speed']]=df[['day','time','weather','temp','wind_speed']].astype("float64")
    df["rush_hr"]=(df['time']).astype('int64')
    df['rush_hr']=df['rush_hr'].replace(RUSH[stationnumber][day])
    df['number']=stationnumber
    df['weekday']=df['day']
    df['weekday']=df['weekday'].replace({0:1, 1:1, 2:1, 3:1, 4:1, 5:0, 6:0})

    filename = os.path.join(app.root_path,'dataAnalytics', str(stationnumber))
    newDict = pickle.load(open(filename,'rb'))
    #loads the correct model
    if df.weekday[0]==1:
        model = newDict['weekday']
        df = df.reindex(columns = newDict['weekdayFeatures'])
    else:
        model = newDict['weekend']
        df = df.reindex(columns = newDict['weekendFeatures'])
    #makes the predictions
    scaler = MinMaxScaler(feature_range = (0,1))
    df = scaler.fit_transform(df)
    result = list(model.predict(df))

    #converts the times and predictions before sending it back
    i=timeL.index((int(time)))
    result = [round(v) for v in result]
    timeI=[]
    for y in timeL:
        if y%100 == 0:
            timeI.append(int(y))
        elif (y-25)%100 == 0:
            timeI.append(int(y-10))
        elif y%10 == 0 and y%100 != 0:
            timeI.append(int(y-20))
        else:
            timeI.append(int(y-30))
    timeT=timeL.copy()
    timeL = []
    for y in timeT:
        if y%100 == 0:
            timeL.append(str(int(y)))
        elif (y-25)%100 == 0:
            timeL.append(str(int(y-10)))
        elif y%10 == 0 and y%100 != 0:
            timeL.append(str(int(y-20)))
        else:
            timeL.append(str(int(y-30)))
    dictionary = [timeI, result, {timeL[i]:result[i]}]
    return json.dumps(dictionary)
