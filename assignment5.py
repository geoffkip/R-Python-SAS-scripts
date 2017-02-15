import pandas as pd
import matplotlib.pyplot as plt
import matplotlib

from pandas.tools.plotting import andrews_curves

# Look pretty...
# matplotlib.style.use('ggplot')
plt.style.use('ggplot')



df=pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module3/Datasets/wheat.data")
df.head


df = df.drop(labels=['id'], axis = 1)

#
# TODO: Plot a parallel coordinates chart grouped by
# the 'wheat_type' feature. 

plt.figure()
andrews_curves(df, 'wheat_type', alpha = 0.4)

plt.show()


