import unittest
from flask import url_for
from run import app
import json
import cleanData
import random
import datetime
from datetime import datetime as dt
import csv
from cleanData import createDF

class TestMain(unittest.TestCase): 
    def test_get_marker_data_goodData(self):
        with app.test_client() as c:
            x = c.post('/getMarkerData', data={'name': 'ROTHE ABBEY'})
            self.assertEqual(x.data[0:19],b'#Name: ROTHE ABBEY#')

    def test_get_marker_data_badData(self):
        with app.test_client() as c:
            x = c.post('/getMarkerData', data={'phone': 92389})
            self.assertEqual(x.status_code,400)

    def test_get_historicalData_goodData(self):
        with app.test_client() as c:
            x = c.post('/histData', data={'name': "ROTHE ABBEY"})
            x = json.loads(x.data) 
            self.assertEqual(type(x), list)
    def test_get_historicalData_badData(self):
        with app.test_client() as c:
            x = c.post('/histData', data={'date': 123})
            self.assertEqual(x.status_code,400)
    def test_get_markers(self):
        with app.test_client() as c:
            x = c.post('/markers')
            x = json.loads(x.data) 
            self.assertEqual(type(x), list)
    def test_toggles_goodData(self):
        with app.test_client() as c:
            x = c.post('/toggleMarkers', data = {'toggle1': ">=0", "toggle2" : ">=0"})
            x = json.loads(x.data) 
            self.assertEqual(type(x), list)    
    def test_toggles_badData(self):
        with app.test_client() as c:
            x = c.post('/toggleMarkers', data = {'tosdasggle1': 23, "toggasdsle2" : 121})
            self.assertEqual(x.status_code,400)
    def test_stationLoc(self):
        with app.test_client() as c:
            x = c.post('/stationLoc', data = {'name' : "Rothe Abbey"})
            self.assertEqual(x.data, b'53.338776,-6.30395')
    def test_stationLoc_badData(self):
        with app.test_client() as c:
            x = c.post('/toggleMarkers', data = {'tosdasggle1': 23, "toggasdsle2" : 121})
            self.assertEqual(x.status_code,400)
    def test_returnData(self):  
        name='ROTHE ABBEY'
        time="1300"
        date='04/19/2019'
        
        self.assertEqual(len(json.loads(createDF(name, date, time))) , 3)
        for e in json.loads(createDF(name, date, time))[0]:
            self.assertIsInstance(e, int)
        date='04/21/2019'
        self.assertEqual(len(json.loads(createDF(name, date, time))) , 3)
        for e in json.loads(createDF(name, date, time))[0]:
            self.assertIsInstance(e, int)


if __name__ == '__main__':
    unittest.main(argv=['ignored', '-v'], exit=False)
