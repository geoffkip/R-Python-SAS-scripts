
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

matplotlib.style.use('ggplot') # Look Pretty


def drawLine(model, X_test, y_test, title, R2):
  # This convenience method will take care of plotting your test observations, comparing them to the regression line, and
  # displaying the R2 coefficient
  fig = plt.figure()
  ax = fig.add_subplot(111)
  ax.scatter(X_test, y_test, c = 'g', marker = 'o')
  ax.plot(X_test, model.predict(X_test), color = 'orange', linewidth = 1, alpha = 0.7)

  title += " R2: " + str(R2)
  ax.set_title(title)
  print title
  print "Intercept(s): ", model.intercept_

  plt.show()

def drawPlane(model, X_test, y_test, title, R2):
  # This convenience method will take care of plotting your test observations, comparing them to the regression plane,
  # and displaying the R2 coefficient
  fig = plt.figure()
  ax = Axes3D(fig)
  ax.set_zlabel('prediction')

  # You might have passed in a DataFrame, a Series (slice), an NDArray, or a Python List... so let's keep it simple:
  X_test = np.array(X_test)
  col1 = X_test[:,0]
  col2 = X_test[:,1]

  # Set up a Grid. We could have predicted on the actual col1, col2 values directly; but that would have generated
  # a mesh with WAY too fine a grid, which would have detracted from the visualization
  x_min, x_max = col1.min(), col1.max()
  y_min, y_max = col2.min(), col2.max()
  x = np.arange(x_min, x_max, (x_max-x_min) / 10)
  y = np.arange(y_min, y_max, (y_max-y_min) / 10)
  x, y = np.meshgrid(x, y)

  # Predict based on possible input values that span the domain of the x and y inputs:
  z = model.predict(  np.c_[x.ravel(), y.ravel()]  )
  z = z.reshape(x.shape)

  ax.scatter(col1, col2, y_test, c='g', marker='o')
  ax.plot_wireframe(x, y, z, color='orange', alpha=0.7)

  title += " R2: " + str(R2)
  ax.set_title(title)
  print title
  print "Intercept(s): ", model.intercept_

  plt.show()


X = pd.read_csv('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module5/Datasets/College.csv', index_col = 0)
print X.head()
print X.info
print X.describe()
print X.dtypes
print X.isnull().sum() # No missing values!
print X.columns


X.Private = X.Private.map({'Yes':1, 'No':0})

from sklearn import linear_model
model = linear_model.LinearRegression()


s1 = X.Accept
s2 = X[['Room.Board']]
print type(s1), type(s2) # Remember train_test_split can only handle DataFrames, not Series!
s1 = s1.to_frame()

from sklearn.cross_validation import train_test_split
X_train1, X_test1, y_train1, y_test1 = train_test_split(s1, s2, test_size = 0.3, random_state = 7)

#
# TODO: Fit and score your model appropriately. Store the score in the score variable.
#
# .. your code here ..
model1 = model.fit(X_train1, y_train1)
score1 = model1.score(X_test1, y_test1)

drawLine(model1, X_test1, y_test1, "Accept(Room&Board)", score1)

#
# TODO: Duplicate the process above; this time, model the number of enrolled students per college, as a function of the number of
# accepted students

s3 = X.Enroll.to_frame()
X_train2, X_test2, y_train2, y_test2 = train_test_split(s1, s3, test_size = 0.3, random_state = 7)
model2 = model.fit(X_train2, y_train2)
score2 = model2.score(X_test2, y_test2)
drawLine(model2, X_test2, y_test2, "Accept(Enroll)", score2)

#
# TODO: Duplicate the process above; this time, model the number of failed undergraduate students per college, as a function of
# the number of accepted students
#
# .. your code here ..
s4 = X[['F.Undergrad']]
X_train3, X_test3, y_train3, y_test3 = train_test_split(s1, s4, test_size = 0.3, random_state = 7)
model3 = model.fit(X_train3, y_train3)
score3 = model3.score(X_test3, y_test3)
drawLine(model3, X_test3, y_test3, "Accept(F.Undergrad)", score3)

#
# Model the number of accepted students, as a function of the amount charged for room and board, AND the number of enrolled students.
# To do this, instead of creating a regular slice for a single-feature input, simply create a slice that contains both columns you
# wish to use as inputs. Your training labels will remain a single slice.
#
# .. your code here ..
s5 = X[['Room.Board', 'Enroll']]
X_train4, X_test4, y_train4, y_test4 = train_test_split(s5, s1, test_size = 0.3, random_state = 7)
model4 = model.fit(X_train4, y_train4)
score4 = model4.score(X_test4, y_test4)
drawPlane(model4, X_test4, y_test4, "Accept(Room&Board,Enroll)", score4)

