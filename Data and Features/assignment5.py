import pandas as pd
import numpy as np


#
# TODO:
# Load up the dataset, setting correct header labels.
#
# .. your code here ..

df = pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module2/Datasets/census.data", names = ['education', 'age', 'capital-gain', 'race', 'capital-loss', 'hours-per-week', 'sex', 'classification'])
df[df == 0] = np.nan
#

print (df.dtypes)

#
# TODO:
# Look through your data and identify any potential categorical
# features. Ensure you properly encode any ordinal and nominal
# types using the methods discussed in the chapter.

print (df.education.unique())
education_ordered = ['Preschool', '1st-4th', '5th-6th', '7th-8th', '9th', '10th', '11th', '12th', 'HS-grad', 'Some-college', 'Bachelors', 'Masters', 'Doctorate']
df.education = df.education.astype("category", ordered = True, categories = education_ordered).cat.codes
#


df = pd.get_dummies(df, columns=['race'])
print (df.sex.unique())
# sex categories: ['Male' 'Female']
df = pd.get_dummies(df, columns=['sex'])
print (df.classification.unique())
# classification categories: ['<=50K' '>50K']
df = pd.get_dummies(df, columns=['classification'])

