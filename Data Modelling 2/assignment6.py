import pandas as pd
import time

# Grab the DLA HAR dataset from:
# http://groupware.les.inf.puc-rio.br/har
# http://groupware.les.inf.puc-rio.br/static/har/dataset-har-PUC-Rio-ugulino.zip


#
# TODO: Load up the dataset into dataframe 'X'

X = pd.read_csv('Datasets/dataset-har-PUC-Rio-ugulino.csv', sep = ';', decimal = ',')
print X.head()

#
# TODO: Encode the gender column, 0 as male, 1 as female

X.gender = X.gender.map({'Man': 0, 'Woman': 1})
print X.head(6)


# Check data types
print X.dtypes

#
# TODO: Convert any column that needs to be converted into numeric

X.z4 = pd.to_numeric(X.z4, errors = 'coerce')
print X.isnull().sum()
X.dropna(axis = 0, how = 'any', inplace = True)

#
# TODO: Encode your 'y' value as a dummies version of your dataset's "class" column

y = X[['class']]
y = pd.get_dummies(y)

#
# TODO: Get rid of the user and class columns

X.drop(labels = ['user', 'class'], axis = 1, inplace = True)
print X.describe()

print X[pd.isnull(X).any(axis=1)]

#
# TODO: Create an RForest classifier 'model' and set n_estimators = 30, the max_depth to 10, and oob_score = True, and random_state = 0
#
from sklearn.ensemble import RandomForestClassifier
forest = RandomForestClassifier(n_estimators = 30, max_depth = 10, oob_score = True, random_state = 0)

# 
# TODO: Split your data into test / train sets


from sklearn.cross_validation import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.3, random_state = 7)

print "Fitting..."
s = time.time()
#
# TODO: train your model on your training set
#
# .. your code here ..
model = forest.fit(X_train, y_train)
print "Fitting completed in: ", time.time() - s

#
# INFO: Display the OOB Score of your data
score = model.oob_score_
print "OOB Score: ", round((score*100), 3)

print "Scoring..."
s = time.time()
#
# TODO: score your model on your test set
#
# .. your code here ..
score = model.score(X_test, y_test)
print "Score: ", round((score*100), 3)
print "Scoring completed in: ", time.time() - s

