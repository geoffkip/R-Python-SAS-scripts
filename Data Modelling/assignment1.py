#
# TODO: Import whatever needs to be imported to make this work
#
# .. your code here ..
import pandas as pd
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import matplotlib
matplotlib.style.use('ggplot') # Look Pretty



df=pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module5/Datasets/Crimes_-_2001_to_present.csv")

df.dropna(axis = 0, how = 'any', inplace = True)

print df.dtypes

df.Date = pd.to_datetime(df.Date) # Converts the entries in the 'Date' column to datetime64[ns]
print df.dtypes

def doKMeans(df):
  #
  # INFO: Plot your data with a '.' marker, with 0.3 alpha at the Longitude,
  # and Latitude locations in your dataset. Longitude = x, Latitude = y
  fig = plt.figure()
  ax = fig.add_subplot(111)
  ax.scatter(df.Longitude, df.Latitude, marker='.', alpha=0.3)

  #
  # TODO: Filter df so that you're only looking at Longitude and Latitude,
  # since the remaining columns aren't really applicable for this purpose.
  #

  
  df = pd.concat([df.Longitude, df.Latitude], axis = 1)

  #
  # TODO: Use K-Means to try and find seven cluster centers in this df.

  
  kmeans_model = KMeans(n_clusters = 7, init = 'random', n_init = 60, max_iter = 360, random_state = 43)
  labels = kmeans_model.fit_predict(df)

  #
  # INFO: Print and plot the centroids...
  centroids =  kmeans_model.cluster_centers_
  ax.scatter(centroids[:,0], centroids[:,1], marker='x', c='red', alpha=0.5, linewidths=3, s=169)
  print centroids



# INFO: Print & Plot your data
doKMeans(df)


#
# TODO: Filter out the data so that it only contains samples that have
# a Date > '2011-01-01', using indexing. Then, in a new figure, plot the
# crime incidents, as well as a new K-Means run's centroids.
#
# .. your code here ..

df2 = df[df.Date > '2011-01-01']


# INFO: Print & Plot your data
doKMeans(df2)
plt.title("Dates limited to 2011 and later")
plt.show()


