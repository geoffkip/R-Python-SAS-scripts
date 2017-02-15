import pandas as pd
import matplotlib.pyplot as plt
import matplotlib
import assignment2_helper as helper

# Look pretty...
# matplotlib.style.use('ggplot')
plt.style.use('ggplot')


# Do * NOT * alter this line, until instructed!
scaleFeatures = False



df=pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module4/Datasets/kidney_disease.csv")
df.dropna(axis = 0, how = 'any', inplace = True)
df = df.drop(labels=['id'], axis = 1)
df.head


# Create some color coded labels; the actual label feature
# will be removed prior to executing PCA, since it's unsupervised.
# You're only labeling by color so you can see the effects of PCA
labels = ['red' if i=='ckd' else 'green' for i in df.classification]


df = df[['bgr', 'wc', 'rc']]




print df
print df.dtypes 	# The columns are all of type "object"
df.bgr = pd.to_numeric(df.bgr)
df.wc = pd.to_numeric(df.wc)
df.rc = pd.to_numeric(df.rc)
print df
print df.dtypes 



print df.var()
print "This is the describe output: ", df.describe()


# TODO: This method assumes your dataframe is called df. If it isn't,
# make the appropriate changes. Don't alter the code in scaleFeatures()
# just yet though!
#
# .. your code adjustment here ..
if scaleFeatures: df = helper.scaleFeatures(df)



# TODO: Run PCA on your dataset and reduce it to 2 components
# Ensure your PCA instance is saved in a variable called 'pca',
# and that the results of your transformation are saved in 'T'.
#
# .. your code here ..

from sklearn.decomposition import PCA
pca = PCA(n_components = 2)
pca.fit(df)
T = pca.transform(df)

#
ax = helper.drawVectors(T, pca.components_, df.columns.values, plt, scaleFeatures)
T = pd.DataFrame(T)
T.columns = ['component1', 'component2']
T.plot.scatter(x='component1', y='component2', marker='o', c=labels, alpha=0.75, ax=ax)
plt.show()


