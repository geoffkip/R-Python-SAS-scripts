import pandas as pd
import math

# The Dataset comes from:
# https://archive.ics.uci.edu/ml/datasets/Optical+Recognition+of+Handwritten+Digits

def load(path_test, path_train):
  # Load up the data.
  # You probably could have written this..
  with open(path_test, 'r')  as f: testing  = pd.read_csv(f)
  with open(path_train, 'r') as f: training = pd.read_csv(f)

  # The number of samples between training and testing can vary
  # But the number of features better remain the same!
  n_features = testing.shape[1]

  X_test  = testing.ix[:,:n_features-1]
  X_train = training.ix[:,:n_features-1]
  y_test  = testing.ix[:,n_features-1:].values.ravel()
  y_train = training.ix[:,n_features-1:].values.ravel()

  #
  # Special:
  X_train = X_train[:int(len(X_train.index)*0.04)]
  y_train = y_train[:int(math.ceil(y_train.shape[0])*0.04)]

  return X_train, X_test, y_train, y_test


def peekData():
  # The 'targets' or labels are stored in y. The 'samples' or data is stored in X
  print "Peeking your data..."
  fig = plt.figure()

  cnt = 0
  for col in range(5):
    for row in range(10):
      plt.subplot(5, 10, cnt + 1)
      plt.imshow(X_train.ix[cnt,:].reshape(8,8), cmap=plt.cm.gray_r, interpolation='nearest')
      plt.axis('off')
      cnt += 1
  fig.set_tight_layout(True)
  plt.show()


def drawPredictions():
  fig = plt.figure()

  # Make some guesses
  y_guess = model.predict(X_test)
  
  num_rows = 10
  num_cols = 5

  index = 0
  for col in range(num_cols):
    for row in range(num_rows):
      plt.subplot(num_cols, num_rows, index + 1)

      # 8x8 is the size of the image, 64 pixels
      plt.imshow(X_test.ix[index,:].reshape(8,8), cmap=plt.cm.gray_r, interpolation='nearest')

      # Green = Guessed right
      # Red = Fail!
      fontcolor = 'g' if y_test[index] == y_guess[index] else 'r'
      plt.title('Label: %i' % y_guess[index], fontsize=6, color=fontcolor)
      plt.axis('off')
      index += 1
  fig.set_tight_layout(True)
  plt.show()


#
# TODO: Pass in the file paths to the .tes and the .tra files
X_train, X_test, y_train, y_test = load('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module6/Datasets/optdigits.tes', '/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module6/Datasets/optdigits.tra')

import matplotlib.pyplot as plt
from sklearn import svm

# 
# Get to know data. It seems its already well organized in
# [n_samples, n_features] form. 
peekData()

#
# =Create an SVC classifier. Leave C=1, but set gamma to 0.001
# and set the kernel to linear. Then train the model on the testing
# data / labels:
print "Training SVC Classifier..."

from sklearn.svm import SVC
model = SVC(C = 1, gamma = 0.001, kernel = 'linear')
model.fit(X_train, y_train)

# TODO: Calculate the score of your SVC against the testing data
print "Scoring SVC Classifier..."
#
# .. your code here ..
score = model.score
print "Score:\n", score(X_test, y_test)

# Visual Confirmation of accuracy
drawPredictions()

#
# TODO: Print out the TRUE value of the 1000th digit in the test set
#
# .. your code here ..
true_1000th_test_value = y_test[1000]
print "1000th test label: ", true_1000th_test_value

#
# TODO: Predict the value of the 1000th digit in the test set.

y_pred = model.predict(X_test)
guess_1000th_test_value = y_pred[1000]
print "1000th test prediction: ", guess_1000th_test_value


plt.imshow(X_test.ix[1000, :].reshape(8, 8), cmap = plt.cm.gray_r, interpolation = 'nearest')
