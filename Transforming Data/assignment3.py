import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
import assignment2_helper as helper

# Look pretty...
matplotlib.style.use('ggplot')


# Do * NOT * alter this line, until instructed!
scaleFeatures = False

df=pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module4/Datasets/kidney_disease.csv")

# Create some color coded labels; the actual label feature will be removed prior to executing PCA, since it's unsupervised.
# You're only labeling by color so you can see the effects of PCA.
labels = ['red' if i=='ckd' else 'green' for i in df.classification]


df.drop(labels = ['id', 'classification', 'rbc', 'pc', 'pcc', 'ba', 'htn', 'dm', 'cad', 'appet', 'pe', 'ane'], axis = 1, inplace = True)
#print df.head()

df.pcv = pd.to_numeric(df.pcv, errors = 'coerce')
df.wc = pd.to_numeric(df.wc, errors = 'coerce')
df.rc = pd.to_numeric(df.rc, errors = 'coerce')
#print df.dtypes # Now everything is floats

# Need to remove the NaN values from the dataframe:
df.dropna(axis = 0, how = 'any', inplace = True)
print df

print df.var()
print "This is the describe output: ", df.describe()

if scaleFeatures: df = helper.scaleFeatures(df)


# TODO: Run PCA on your dataset and reduce it to 2 components. Ensure your PCA instance is saved in a variable called 'pca',
# and that the results of your transformation are saved in 'T'.
#
# .. your code here ..
from sklearn.decomposition import PCA
pca = PCA(n_components = 2)
pca.fit(df)
T = pca.transform(df)


ax = helper.drawVectors(T, pca.components_, df.columns.values, plt, scaleFeatures)
T = pd.DataFrame(T)
T.columns = ['component1', 'component2']
T.plot.scatter(x='component1', y='component2', marker='o', c = labels, alpha=0.75, ax=ax)
plt.show()