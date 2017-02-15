# -*- coding: utf-8 -*-
"""
Created on Mon Jan 30 14:22:46 2017

@author: gkip
"""

from sklearn import datasets
iris = datasets.load_iris()
iris.data.shape

iris.target.shape

import numpy as np
print (iris.target)
np.unique(iris.target)

digits = datasets.load_digits()
digits.images.shape

import pylab as pl
pl.imshow(digits.images[0], cmap=pl.cm.gray_r) 
data = digits.images.reshape((digits.images.shape[0], -1))


from sklearn import svm
clf = svm.LinearSVC()
clf.fit(iris.data, iris.target) # learn from the data 

clf.predict([[ 5.0,  3.6,  1.3,  0.25]])

clf.coef_

from sklearn import neighbors
knn = neighbors.KNeighborsClassifier()
knn.fit(iris.data, iris.target) 
knn.predict([[0.1, 0.2, 0.3, 0.4]])

perm = np.random.permutation(iris.target.size)
iris.data = iris.data[perm]
iris.target = iris.target[perm]
knn.fit(iris.data[:100], iris.target[:100]) 
knn.score(iris.data[100:], iris.target[100:]) 


from sklearn import svm
svc = svm.SVC(kernel='linear')
svc.fit(iris.data, iris.target) 

from sklearn import cluster, datasets
iris = datasets.load_iris()
k_means = cluster.KMeans(n_clusters=3)
k_means.fit(iris.data) 
print(k_means.labels_[::10])
print(iris.target[::10])


##image processing
from scipy import misc
face = misc.face(gray=True).astype(np.float32)
X = face.reshape((-1, 1))  # We need an (n_sample, n_feature) array
K = k_means = cluster.KMeans(n_clusters=5)  # 5 clusters
k_means.fit(X) 
values = k_means.cluster_centers_.squeeze()
labels = k_means.labels_
face_compressed = np.choose(labels, values)
face_compressed.shape = face.shape


from sklearn import pca
pca = decomposition.PCA(n_components=2)
PCA.fit(iris.data)
pca(copy=True, n_components=2, whiten=False)
X = pca.transform(iris.data)

import pylab as pl
pl.scatter(X[:, 0], X[:, 1], c=iris.target)


#### face recognition

import numpy as np
import pylab as pl
from sklearn import cross_validation, datasets, decomposition, svm

# ..
# .. load data ..
lfw_people = datasets.fetch_lfw_people(min_faces_per_person=70, resize=0.4)
perm = np.random.permutation(lfw_people.target.size)
lfw_people.data = lfw_people.data[perm]
lfw_people.target = lfw_people.target[perm]
faces = np.reshape(lfw_people.data, (lfw_people.target.shape[0], -1))
train, test = iter(cross_validation.StratifiedKFold(lfw_people.target, k=4)).next()
X_train, X_test = faces[train], faces[test]
y_train, y_test = lfw_people.target[train], lfw_people.target[test]

# ..
# .. dimension reduction ..
pca = decomposition.RandomizedPCA(n_components=150, whiten=True)
pca.fit(X_train)
X_train_pca = pca.transform(X_train)
X_test_pca = pca.transform(X_test)

# ..
# .. classification ..
clf = svm.SVC(C=5., gamma=0.001)
clf.fit(X_train_pca, y_train)

# ..
# .. predict on new images ..
for i in range(10):
    print(lfw_people.target_names[clf.predict(X_test_pca[i])[0]])
    _ = pl.imshow(X_test[i].reshape(50, 37), cmap=pl.cm.gray)
    _ = raw_input()
























































