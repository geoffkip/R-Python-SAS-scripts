import pandas as pd
import numpy as np

# Load up the /Module6/Datasets/parkinsons.data data set into a variable X, being sure to drop the name column.
X = pd.read_csv('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module6/Datasets/parkinsons.data')
X.drop('name', axis = 1, inplace = True)
print X.head()
print X.info
print X.describe()
print X.isnull().sum() # No NaNs!
print X.dtypes # All object types are correct!

# Splice out the status column into a variable y and delete it from X.
y = X.status
X.drop('status', axis = 1, inplace = True)
print X.columns # 'status' has been dropped from X

#  Pull open the dataset's label file from: https://archive.ics.uci.edu/ml/datasets/Parkinsons
# Look at the units on those columns: Hz, %, Abs, dB, etc. What happened to transforming your data? With all of those units
# interacting with one another, some pre-processing is surely in order. 
from sklearn import preprocessing

#T = preprocessing.StandardScaler().fit_transform(X)
#T = preprocessing.MinMaxScaler().fit_transform(X)
#T = preprocessing.Normalizer().fit_transform(X)
T = preprocessing.scale(X)
#T = X # No Change

# So try experimenting with PCA n_component values between 4 and 14. Are you able
# to get a better accuracy?
'''
from sklearn.decomposition import PCA
pca = PCA(n_components = 14)
X_pca = pca.fit_transform(T)
'''
# No, the accuracy levels off at the same value as before from 7 components onwards.

# If you are not, then forget about PCA entirely, unless you want to visualize your data. However if you are able to get a higher score,
# then be *sure* keep that figure in mind, and comment out all the PCA code.
# In the same spot, run Isomap on the data, before sending it to the train / test split. Manually experiment with every inclusive
# combination of n_neighbors between 2 and 5, and n_components between 4 and 6. Are you able to get a better accuracy?
from sklearn.manifold import Isomap

best_score = 0
for k in range(2, 6):
    for l in range(4, 7):
        iso = Isomap(n_neighbors = k, n_components = l)
        X_iso = iso.fit_transform(T)

        # Perform a train/test split. 30% test group size, with a random_state equal to 7.
        from sklearn.cross_validation import train_test_split
        X_train, X_test, y_train, y_test = train_test_split(X_iso, y, test_size = 0.3, random_state = 7)

        # Create a SVC classifier. 
        from sklearn.svm import SVC

        '''
        model = SVC()
        model.fit(X_train, y_train)
        score = model.score(X_test, y_test)
        print score
        '''

        # Program a naive, best-parameter searcher by creating a nested for-loops. The outer for-loop should iterate a variable C
        # from 0.05 to 2, using 0.05 unit increments. 
      
        for i in np.arange(start = 0.05, stop = 2.05, step = 0.05):
            for j in np.arange(start = 0.001, stop = 0.101, step = 0.001):
                model = SVC(C = i, gamma = j)
                model.fit(X_train, y_train)
                score = model.score(X_test, y_test)
                if score > best_score:
                    best_score = score
                    best_C = model.C
                    best_gamma = model.gamma
                    best_n_neighbors = iso.n_neighbors
                    best_n_components = iso.n_components
print "The highest score obtained:", best_score
print "C value:", best_C 
print "gamma value:", best_gamma
print "isomap n_neighbors:", best_n_neighbors
print "isomap n_components:", best_n_components