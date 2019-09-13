# SoftEng2019Proj
Available on http://ec2-107-20-121-105.compute-1.amazonaws.com/

## Introduction
This web application shows the availability of Dublin Bikes around the city. It predicts the availability of bikes at every station upto four days into the future.

## Prerequisites
MySQL, Python3.7, Anaconda/Miniconda

## Instructions
1. Install virtual environment and requirements
<ul>conda create --prefix ./flask/venv python=3.7</ul>
<ul>conda activate ./flask/venv</ul>
<ul>pip install -r requirements.txt</ul>

2. Create neccessary database and tables using the following commands:
<ul>mysql -u <username> -p</ul>
<ul>CREATE DATABASE IF NOT EXISTS bikeInfo</ul>
<ul>use bikeInfo</ul>
<ul>source ./bikes.sql;</ul>
<ul>quit</ul>
  
3. Create .env file and populate with database and API information
vi ./.env
  
JCD_API=<API KEY> //Get key from https://developer.jcdecaux.com/#/opendata/vls?page=getstarted <br>
HOST= // e.g. 127.0.0.1 <br>
DB="bikeInfo" <br>
NAME= //e.g. "root" <br>
PASSWORD= //e.g. "password" <br>
WEATHER_API=<API key> //Get key from https://openweathermap.org/forecast5

4. Run scrapers. These need to be run constantly to have up-to-date information
<ul>nohup python ./scrapers/dynamicBikeMine.py & </ul>
<ul>nohup python ./scrapers/dynamicWeatherMine.py & </ul>

5. Run the application 
<ul>python ./flask/run.py</ul>

## Team
ankhitp
philip-mcgrath
niamh-c
