import pandas as pd
import pymysql
from datetime import datetime
import pickle
import time
from sklearn.model_selection import train_test_split,cross_validate
from sklearn.preprocessing import MinMaxScaler
from sklearn.ensemble import RandomForestRegressor
import math
from flask.dataAnalytics.makemodels import dR
import os
from dotenv import load_dotenv

load_dotenv()
apiKey = os.getenv("JCD_API")
DB_host = os.getenv("HOST")
DB_database=os.getenv("DB")
DB_user=os.getenv("NAME")
DB_password=os.getenv("PASSWORD")

while True:
    #Conecting to the database
    conn = pymysql.connect(DB_host, user=DB_user,port=3306,passwd=DB_password, db=DB_database)
    query = "SELECT * FROM dynamicData WHERE last_update BETWEEN '"+startdate+"' AND '"+newdate+"'"
    df = pd.read_sql(query, conn)
    query = "SELECT * FROM dynamicWeather WHERE last_time BETWEEN '"+startdate+"' AND '"+newdate+"'"
    df1=pd.read_sql(query, conn) #weather dataframe
    conn.close()

    #Merging the two databases
    #Drop Duplicates
    df=df.drop_duplicates()
    df1=df1.drop_duplicates()

    #Change datetime columns for sorting and merge
    df1['last_time'] = df1['last_time'].astype('datetime64[ns]')
    df['last_update'] = df['last_update'].astype('datetime64[ns]')


    #Sort Data by lastest date
    df=df.sort_values('last_update')
    df1=df1.sort_values('last_time')


    # Joins the data with a time tolerance of 2 hours(account for missing weather data)
    df=pd.merge_asof(df, df1, left_on='last_update', right_on='last_time', direction='nearest', tolerance=pd.Timedelta(hours=3))

    #Cleaning the dataset
    #At the beginning of our data collection we didn't collect some data which we now need.
    #Code to replace that data
    dfdict=pd.read_csv('NameNumberbanking.csv')#CSV with all missing data
    dfdict['name']=dfdict['name'].astype('category')
    nameNodict=dict()
    for i in dfdict.loc[(dfdict['number'].notnull())].index:
        key=dfdict.at[i, 'name']
        nameNodict[key]=int(dfdict.at[i, 'number'])
    for i in df.index:
        df.at[i,'number']=nameNodict[df.at[i, 'name']]

    #Change column types for columns that won't be dropped
    df[['visibility', 'number', 'wind_speed', 'temp']]=df[['visibility', 'number', 'wind_speed', 'temp']].astype('float64')

    #Find rows with missing weather data and drop them
    df=df.iloc[(df.loc[df.visibility>=0].index)]

    #Drop columns we will not be using
    df=df.drop(["name", "avail_bike_stands", "last_time", 'banking', 'status', 'visibility', 'bike_stands'],1)

    #Add in extra useful columns and format them
    df['day']=df['last_update'].dt.dayofweek
    df['weekday']=1
    for i in df.loc[df['day'].isin([5,6])].index:
        df.at[i,'weekday']=0

    #We are working with time splits of 30 minutes.
    df["time"]=df['last_update'].dt.round('30min')
    df['time']=df["time"].dt.strftime('%H%M')
    df['time']=df.time.astype('int64')
    #Slpit time into evenly. Convert halves into 50 values e.g. 230->250
    TIME=pickle.load(open("time_dict","rb"))#Saved as a pickle as we use in flask to convert time
    df.time=df.time.replace(TIME)

    #Weather was the hardest to format well we tried a few different ways for format it (binary encoding, temp*weather,
    #keeping only weather) and found that the method below gave us the best results when evaluated.
    df['weather']=None
    df['weather']=None
    Weather={'Smoke':1, 'Haze':5,  'sand':1,  'volcanic ash':1, 'squalls':1,'tornado':0, 'sand/ dust whirls':1,\
             'dust':1, 'heavy thunderstorm': 5, 'thunderstorm with rain':3, 'thunderstorm with heavy rain':2,\
             'extreme rain':0, 'heavy intensity rain': 2, 'Heavy snow':1, 'very heavy rain':1, 'freezing rain':3,\
             'heavy shower snow':3, 'snow': 3, 'thunderstorm with light rain':3, 'sleet':3,\
             'heavy shower rain and drizzle':4, 'thunderstorm with heavy drizzle':4, 'heavy intensity shower rain':4,\
             'shower rain':5, 'heavy intensity drizzle rain':5, 'shower sleet':5, 'light rain and snow':5,\
             'rain and snow':4, 'moderate rain':4, 'shower snow':5, 'heavy intensity drizzle':5,\
             'thunderstorm with drizzle':6, 'thunderstorm with light drizzle':6, 'drizzle rain':6,\
             'shower rain and drizzle':6,  'Light shower sleet':6, 'Light shower snow':6, 'drizzle':6, 'fog':7,\
             'mist':7, 'thunderstorm':7, 'light intensity drizzle': 7, 'light intensity drizzle rain':7,\
             'shower drizzle':7, 'light rain':7, 'light intensity shower rain':7,'ragged shower rain':7,\
             'light thunderstorm':8, 'ragged thunderstorm':8, 'overcast clouds':6, 'few clouds':10,\
             'scattered clouds': 11, 'broken clouds': 9, 'clear sky':13}


    #Use integer incoding in our dataframe
    for i in df.index:
        df.at[i,'weather']=Weather[df.at[i,'description']]
    df=df.drop('main',1)
    df=df.drop('description',1)

    #Clamp avail_bikes outliers
    def clampLB(minV,maxV, Q3, Q1):
        return max(minV, Q1-1.5*(Q3-Q1))
    def clampUB(minV, maxV, Q3, Q1):
        return min(maxV, Q3+1.5*(Q3-Q1))

    dt=df.copy(deep=True);
    for n in range(0, 113):
        dn=df.loc[(dt.number==n)].copy(deep=True)
        for day in range(0,7):
            df=dn.loc[(dt.day==day)]
            col='avail_bikes'
            UB=clampUB(df[col].min(), df[col].max(), df[col].quantile(.75), df[col].quantile(.25))
            for i in df.loc[(df[col]>=UB)].index:
                dt.at[i, col]=UB
            LB=clampLB(df[col].min(), df[col].max(), df[col].quantile(.75), df[col].quantile(.25))
            for i in df.loc[(df[col]<=LB)].index:
                dt.at[i, col]=LB

    dt['rush_hr']=0
    #A pickle holding a dictonary which tells us how many bike stands are at every station. This was saved in an earlier version.
    bike_stands=pickle.load(open("bike_stands","rb"))
    RushHour=dict()
    meandict=dict()
    for s in dt['number'].unique():
        #select each station individually
        df=dt.loc[(dt['number']==s)]
        #create a dictionary for each station holding the mean amount of bikes available per half hour
        meandict[s]={0:{},1:{},2:{},3:{},4:{},5:{},6:{}}
        #Get mean information per day
        for day in range(0,7):
            df1=df.loc[(df['day']==day)]
            df1=df1.sort_values(['time'])
            mean=list(round(df1.groupby('time')['avail_bikes'].mean()))
            Ltime=list(df1.time.unique())
            #Get mean inforamtion per half hour
            for i in range(0, len(mean)):
                meandict[s][day][Ltime[i]]=mean[i]
        #If there is less that 20% of bikes available at a stand we consider it to be rush hour at that station
        RushHour[s]=dict()
        df1=df1.reset_index(drop=True)
        stands=bike_stands[s]
        for day in range(0,7):
            RushHour[s][day]=dict()
            for i in df.loc[df['day']==day].index:
                if meandict[s][day][df.at[i, 'time']]<round(.2*stands):
                    dt.at[i,'rush_hr']=1
                    RushHour[s][day][df.at[i, 'time']]=1
                else:
                    RushHour[s][day][df.at[i, 'time']]=0
    #save update for flask predictions
    outfile = open('rush_hr_dicts','wb')
    pickle.dump(RushHour,outfile)
    outfile.close()

    #update means for graphs
    dg=pd.DataFrame(columns = ['station','day','time', 'mean',])
    for s in dt['number'].unique():
        for d in range(0,7):
            mean=list(dt.loc[(dt.number==s)&(dt.day==d)].groupby('time')['avail_bikes'].mean())
            for i in range(0, len(list(TIME.values()))):
                dg = dg.append(pd.Series([s, d, list(TIME.keys())[i], round(mean[i])], index=dg.columns ), ignore_index=True)
    dg.to_csv('meansforgraph.csv')

    #convert all features to floats
    cont_features = list(dt.columns.values)
    cont_features.remove('last_update')
    dt[cont_features]=dt[cont_features].astype('float64')
    dR=pd.DataFrame(columns = ['station','model','abs_error', 'squared_error', 'r2', 'last-updated'])

    #create 2 models per station. One for weekdays and one for the weekends.
    for s in dt['number'].unique():
        #split the data into weekday and weekends
        df=dt.loc[(dt['number']==s)]
        weekday=df.loc[df.weekday==1]
        weekend=df.loc[df.weekday==0]
        weekday=weekday.drop('weekday', 1)
        weekend=weekend.drop('weekday', 1)
        models=[weekday, weekend]
        modelsStr=['weekday', 'weekend']
        count=0
        Models={'weekday':None, 'weekend':None}
        for m in models:
            m=m.sort_values(['last_update'])
            m=m.reset_index(drop=True)
            m=m.drop(['last_update'] ,1)
            cont_features = list(m.columns.values)
            cont_features.remove('avail_bikes')

            #Split our dataset into training and testing
            X = m[cont_features]
            y = m.avail_bikes
            X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)
            X_test=X_test.reset_index(drop=True)
            y_test=y_test.reset_index(drop=True)

            # Scaling feature values bewteen 0-1 (prepreprocessing)
            scaler = MinMaxScaler(feature_range=(0, 1));
            X_train = scaler.fit_transform(X_train);
            X_test = scaler.fit_transform(X_test);

            #Fitting the model
            model= RandomForestRegressor(n_estimators=100, random_state=0)
            model.fit(X_train, y_train);

            #Get scores
            scoring = {'abs_error': 'neg_mean_absolute_error', 'squared_error': 'neg_mean_squared_error', 'r2':'r2'}
            scores = cross_validate(model, X_test, y_test, cv=10, scoring=scoring, return_train_score=True)
            if (float(scores['test_r2'].mean()))>float(dO.loc[(dO.station==s)&(dO.model==modelsStr[count])]['r2']):
                dR.loc[(dR.station==s)&(dR.model==modelsStr[count]), 'abs_error']=float(scores['test_abs_error'].mean())
                dR.loc[(dR.station==s)&(dR.model==modelsStr[count]), 'squared_error']=float(math.sqrt(abs(scores['test_squared_error'].mean())))
                dR.loc[(dR.station==s)&(dR.model==modelsStr[count]), 'r2']=float(scores['test_r2'].mean())
                dR.loc[(dR.station==s)&(dR.model==modelsStr[count]), 'last-updated']=datetime.today().strftime('%Y-%m-%d')
                Models[modelsStr[count]]=model
                Models[modelsStr[count]+'Features']=list(cont_features)
                outfile = open(str(int(s)),'wb')
                pickle.dump(Models,outfile)
                outfile.close()
            count+=1
    dR.to_csv('RandomForestScores.csv')

    time.sleep(60100)#for just under a week
    if int(dt.datetime.now().hour) >5: #only update between the hours of 12-5am
        time.sleep((25-int(dt.datetime.now().hour))*60*60)
