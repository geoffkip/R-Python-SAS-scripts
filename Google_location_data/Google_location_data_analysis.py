#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 27 22:46:21 2017

@author: geoffrey.kip
"""
import json
import pandas as pd
import datetime 
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import rcParams
from mpl_toolkits.basemap import Basemap
from pandas.io.json import json_normalize

rcParams['figure.figsize'] = (20, 3)

def load_dataset_file(dataset_file):
    """
    Loads dataset
    """
    with open(dataset_file) as f:
        data = json.load(f)
        return data
    
google_data= load_dataset_file("Location History/Location History.json")
locations= google_data["locations"]
locations=pd.DataFrame(locations)
locations.head(1000)

# convert to typical units
locations['latitudeE7'] = locations['latitudeE7']/float(1e7) 
locations['longitudeE7'] = locations['longitudeE7']/float(1e7)
locations['timestampMs'] = locations['timestampMs'].map(lambda x: float(x)/1000) #to seconds
locations['datetime'] = locations.timestampMs.map(datetime.datetime.fromtimestamp)

locations.rename(columns={'latitudeE7':'latitude', 'longitudeE7':'longitude', 'timestampMs':'timestamp'}, inplace=True)
locations = locations[locations.accuracy < 1000] 
locations.reset_index(drop=True, inplace=True)
print(locations["activity"])
locations.head(100)
locations['year'] = locations['datetime'].dt.year
locations['month'] = locations['datetime'].dt.month

def plot_places(data, title, padding, markersize):
    plt.figure(figsize=(10, 10))
    plt.title(title)
    m = Basemap(projection='gall',
                llcrnrlon=data.longitude.min() - padding,
                llcrnrlat=data.latitude.min() - padding,
                urcrnrlon=data.longitude.max() + padding,
                urcrnrlat=data.latitude.max() + padding,
                resolution='h',
                area_thresh=100)
    m.drawcoastlines()
    m.drawcountries()
    m.fillcontinents(color='gainsboro')
    m.drawmapboundary(fill_color='steelblue')
    x, y = m(data.longitude.values, data.latitude.values)
    m.plot(x, y, 'o', c='r', markersize=markersize, alpha=0.2)
    
plot_places(data=locations, title='all the places I have visited', padding=30, markersize=10)
