import pandas as pd

# TODO: Load up the dataset
# Ensuring you set the appropriate header column names
#
# .. your code here ..
df= pd.read_csv('/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module2/Datasets/servo.data', header=None)
df.columns = ['motor', 'screw', 'pgain', 'vgain', 'class']

df.describe()


df2 = df[df['vgain'] == 5]
len(df2)



df3= df[ (df.motor == 'E') & (df.screw == 'E') ]
len(df3)



df4= df[df.pgain == 4]
df.vgain.mean()


df.dtypes

