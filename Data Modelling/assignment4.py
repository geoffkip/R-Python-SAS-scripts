import numpy as np
import pandas as pd
from sklearn import preprocessing
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import matplotlib


#
# TODO: Parameters to play around with
PLOT_TYPE_TEXT = False    # If you'd like to see indices
PLOT_VECTORS = True       # If you'd like to see your original features in P.C.-Space


matplotlib.style.use('ggplot') # Look Pretty
c = ['red', 'green', 'blue', 'orange', 'yellow', 'brown']

def drawVectors(transformed_features, components_, columns, plt):
  num_columns = len(columns)

  # This function will project your *original* feature (columns) onto your principal component feature-space, so that you can
  # visualize how "important" each one was in the multi-dimensional scaling
  
  # Scale the principal components by the max value in the transformed set belonging to that component
  xvector = components_[0] * max(transformed_features[:,0])
  yvector = components_[1] * max(transformed_features[:,1])

  ## Visualize projections

  # Sort each column by its length. These are your *original* columns, not the principal components.
  import math
  important_features = { columns[i] : math.sqrt(xvector[i]**2 + yvector[i]**2) for i in range(num_columns) }
  important_features = sorted(zip(important_features.values(), important_features.keys()), reverse=True)
  print "Projected Features by importance:\n", important_features

  ax = plt.axes()

  for i in range(num_columns):
    # Use an arrow to project each original feature as a labeled vector on your principal component axes
    plt.arrow(0, 0, xvector[i], yvector[i], color='b', width=0.0005, head_width=0.02, alpha=0.75, zorder=600000)
    plt.text(xvector[i]*1.2, yvector[i]*1.2, list(columns)[i], color='b', alpha=0.75, zorder=600000)
  return ax
    

def doPCA(data, dimensions = 2):
  from sklearn.decomposition import RandomizedPCA
  model = RandomizedPCA(n_components = dimensions)
  model.fit(data)
  return model


def doKMeans(data, clusters = 0):

  model = KMeans(n_clusters = clusters)
  labels = model.fit_predict(data)
  return model.cluster_centers_, model.labels_

df=pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module5/Datasets/Wholesale customers data.csv")
print df
print df.isnull().sum() # Shows that there are no NaNs in the data!


df.drop(labels = ['Channel', 'Region'], axis = 1, inplace = True)


print df.describe()
df.plot.hist()


# Remove top 5 and bottom 5 samples for each column:
drop = {}
for col in df.columns:
  # Bottom 5
  sort = df.sort_values(by=col, ascending=True)
  if len(sort) > 5: sort=sort[:5]
  for index in sort.index: drop[index] = True # Just store the index once

  # Top 5
  sort = df.sort_values(by=col, ascending=False)
  if len(sort) > 5: sort=sort[:5]
  for index in sort.index: drop[index] = True # Just store the index once

print "Dropping {0} Outliers...".format(len(drop))
df.drop(inplace=True, labels=drop.keys(), axis=0)
print df.describe()

T = preprocessing.StandardScaler().fit_transform(df)


# Do KMeans
n_clusters = 3
centroids, labels = doKMeans(T, n_clusters)

#
# TODO: Print out your centroids. They're currently in feature-space, which
# is good. Print them out before you transform them into PCA space for viewing
#
# .. your code here ..
print centroids

display_pca = doPCA(T)
T = display_pca.transform(T)
CC = display_pca.transform(centroids)

# Visualize all the samples. Give them the color of their cluster label
fig = plt.figure()
ax = fig.add_subplot(111)
if PLOT_TYPE_TEXT:
  # Plot the index of the sample, so you can further investigate it in your dset
  for i in range(len(T)): ax.text(T[i,0], T[i,1], df.index[i], color=c[labels[i]], alpha=0.75, zorder=600000)
  ax.set_xlim(min(T[:,0])*1.2, max(T[:,0])*1.2)
  ax.set_ylim(min(T[:,1])*1.2, max(T[:,1])*1.2)
else:
  # Plot a regular scatter plot
  sample_colors = [ c[labels[i]] for i in range(len(T)) ]
  ax.scatter(T[:, 0], T[:, 1], c=sample_colors, marker='o', alpha=0.2)


# Plot the Centroids as X's, and label them
ax.scatter(CC[:, 0], CC[:, 1], marker='x', s=169, linewidths=3, zorder=1000, c=c)
for i in range(len(centroids)): ax.text(CC[i, 0], CC[i, 1], str(i), zorder=500010, fontsize=18, color=c[i])


# Display feature vectors for investigation:
if PLOT_VECTORS: drawVectors(T, display_pca.components_, df.columns, plt)


# Add the cluster label back into the dataframe and display it:
df['label'] = pd.Series(labels, index=df.index)
print df

plt.show()

