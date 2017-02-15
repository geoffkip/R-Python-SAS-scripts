import pandas as pd


# TODO: Load up the table, and extract the dataset
# out of it. If you're having issues with this, look
# carefully at the sample code provided in the reading
#
# .. your code here ..

df= pd.read_html('http://www.espn.com/nhl/statistics/player/_/stat/points/sort/points/year/2015/seasontype/2')[0]


df.columns=['RK', 'PLAYER', 'TEAM', 'GP', 'G', 'A', 'PTS', '+/-', 'PIM', 'PTS/G', 
            'SOG', 'PCT', 'GWG', 'PPG', 'PPA', 'SHG', 'SHA']



# TODO: Get rid of any row that has at least 4 NANs in it,

df2= df.dropna(thresh = (len(df.columns) - 4), axis = 1)




df2.drop([0, 1, 12, 13, 24, 25, 36, 37], axis = 0, inplace = True)

# TODO: Get rid of the 'RK' column


df2.drop('RK', axis = 1, inplace = True)

# TODO: Ensure there are no holes in your index by resetting
# it. By the way, don't store the original index
#
df2.reset_index(inplace = True, drop = True)
print (df)


# TODO: Check the data type of all columns, and ensure those
# that should be numeric are numeric
#


df2.GP = pd.to_numeric(df.GP)
df2.G = pd.to_numeric(df.G)
df2.A = pd.to_numeric(df.A)
df2.PTS = pd.to_numeric(df.PTS)
df2['+/-'] = pd.to_numeric(df['+/-'])
df2.PIM = pd.to_numeric(df.PIM)
df2['PTS/G'] = pd.to_numeric(df['PTS/G'])
df2.SOG = pd.to_numeric(df.SOG)
df2.PCT = pd.to_numeric(df.PCT)
df2.GWG = pd.to_numeric(df.GWG)
df2.PPG = pd.to_numeric(df.PPG)
df2.PPA = pd.to_numeric(df.PPA)
df2.SHG = pd.to_numeric(df.SHG)
df2.SHA = pd.to_numeric(df.SHA)
print (df2.dtypes)


print ("The number of rows in the dataframe is: ", len(df2)) #40
print ("There are", len(df.PCT.unique()), "unique values in the PCT column.") #36
print ("The value you get by adding the GP values at indices 15 and 16 of this table is", df.ix[15, 'GP'] + df.ix[16, 'GP'])