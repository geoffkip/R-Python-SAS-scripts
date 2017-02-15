import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt

matplotlib.style.use('ggplot') # Look Pretty


def drawLine(model, X_test, y_test, title):
  # This convenience method will take care of plotting your
  # test observations, comparing them to the regression line,
  # and displaying the R2 coefficient
  fig = plt.figure()
  ax = fig.add_subplot(111)
  ax.scatter(X_test, y_test, c='g', marker='o')
  ax.plot(X_test, model.predict(X_test), color='orange', linewidth=1, alpha=0.7)

  print "Est 2014 " + title + " Life Expectancy: ", model.predict([[2014]])[0]
  print "Est 2030 " + title + " Life Expectancy: ", model.predict([[2030]])[0]
  print "Est 2045 " + title + " Life Expectancy: ", model.predict([[2045]])[0]

  score = model.score(X_test, y_test)
  title += " R2: " + str(score)
  ax.set_title(title)


  plt.show()

#
# .. your code here ..
X= pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module5/Datasets/life_expectancy.csv", delim_whitespace = True)
X.describe
#
# TODO: Create your linear regression model here and store it in a
# variable called 'model'. Don't actually train or do anything else
# with it yet:
#
# .. your code here ..
from sklearn import linear_model
model = linear_model.LinearRegression()



X_train = X.Year[X.Year < 1986]
y_train = X.WhiteMale[X.Year < 1986]
print type(y_train), type(X_train) # y_train and X_train are Series, as described below; need to convert X_train to DataFrame
print len(X_train), len(y_train) # X_train and y_train are the same length
X_train = X_train.to_frame()



#
# TODO: Train your model then pass it into drawLine with your training
# set and labels. 
model.fit(X_train, y_train)
drawLine(model, X_train, y_train, "WhiteMale")

#
# TODO: Print the actual 2014 WhiteMale life expectancy from your loaded dataset
#
# .. your code here ..
print "Actual 2014 WhiteMale life expectancy from loaded dataset:", X.WhiteMale[(X.Year == 2014)].values[0]

# 
# TODO: Repeat the process, but instead of for WhiteMale, this time select BlackFemale. Create a slice
# for BlackFemales, fit your model, and then call drawLine. 
#
# .. your code here ..
y_train2 = X.BlackFemale[X.Year < 1986]
model2 = model.fit(X_train, y_train2)
drawLine(model2, X_train, y_train2, "BlackFemale")
print "Actual 2014 BlackFemale life expectancy from loaded dataset", X.BlackFemale[(X.Year == 2014)].values[0]

#
#correlation matrix
print X.corr()
plt.imshow(X.corr(), cmap=plt.cm.Blues, interpolation='nearest')
plt.colorbar()
tick_marks = [i for i in range(len(X.columns))]
plt.xticks(tick_marks, X.columns, rotation='vertical')
plt.yticks(tick_marks, X.columns)

plt.show()

