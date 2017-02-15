import pandas as pd
Tutorial= pd.read_csv("/Users/geoffrey.kip/Desktop/Python class/DAT210x-master/Module2/Datasets/tutorial.csv")
Tutorial
Tutorial.describe
Tutorial2= Tutorial.loc[2:4, 'col3']
