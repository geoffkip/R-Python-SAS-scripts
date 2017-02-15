import pandas as pd

from scipy import misc
from mpl_toolkits.mplot3d import Axes3D
import matplotlib
import matplotlib.pyplot as plt

# Look pretty...
matplotlib.style.use('ggplot')


#
# TODO: Start by creating a regular old, plain, "vanilla" python list. You can call it 'samples'.
#
# .. your code here .. 
samples = []

#
# TODO: Write a for-loop that iterates over the images in the Module4/Datasets/ALOI/32/ folder, appending each of them to
# your list. Each .PNG image should first be loaded into a temporary NDArray, just as shown in the Feature
# Representation reading.
#
# Optional: Resample the image down by a factor of two if you have a slower computer. You can also convert the image from
# 0-255  to  0.0-1.0  if you'd like, but that will have no effect on the algorithm's results.
#
# .. your code here .. 
import os

for file in os.listdir('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module4/Datasets/ALOI/32'):
	a = os.path.join('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module4/Datasets/ALOI/32', file)
	img = misc.imread(a).reshape(-1)
	samples.append(img)
print len(samples) # 72, as expected since there 72 files in the folder

for file1 in os.listdir('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module4/Datasets/ALOI/32i'):	# Also append the 32i images to the list/dataframe
	b = os.path.join('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module4/Datasets/ALOI/32i', file1)
	img1 = misc.imread(b).reshape(-1)
	samples.append(img1)

colors = []
for i in range(72):
	colors.append('b')
for j in range(12):
	colors.append('r')


df = pd.DataFrame(samples) # Convert list of numpy arrays to Pandas DataFrame

# Run Isomap on the DataFrame:
from sklearn import manifold
iso = manifold.Isomap(n_neighbors = 6, n_components = 3)
Z = iso.fit_transform(df)

def Plot2D(T, title, x, y):
  fig = plt.figure()
  ax = fig.add_subplot(111)
  ax.set_title(title)
  ax.set_xlabel('Component: {0}'.format(x))
  ax.set_ylabel('Component: {0}'.format(y))
  x_size = (max(T[:,x]) - min(T[:,x])) * 0.08
  y_size = (max(T[:,y]) - min(T[:,y])) * 0.08
  # It also plots the full scatter:
  ax.scatter(T[:,x],T[:,y], marker='.', c = colors, alpha=0.7)

def Plot3D(T, title, x, y, z):
  fig = plt.figure()
  ax = fig.add_subplot(111, projection = '3d')
  ax.set_title(title)
  ax.set_xlabel('Component: {0}'.format(x))
  ax.set_ylabel('Component: {0}'.format(y))
  ax.set_zlabel('Component: {0}'.format(z))
  x_size = (max(T[:,x]) - min(T[:,x])) * 0.08
  y_size = (max(T[:,y]) - min(T[:,y])) * 0.08
  z_size = (max(T[:,z]) - min(T[:,z])) * 0.08
  # It also plots the full scatter:
  ax.scatter(T[:,x],T[:,y],T[:,z], marker='.', c = colors, alpha=0.65)

Plot2D(Z, "Isomap transformed data, 2D", 0, 1)
Plot3D(Z, "Isomap transformed data 3D", 0, 1, 2)

plt.show()

