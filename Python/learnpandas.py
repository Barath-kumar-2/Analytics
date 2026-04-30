import pandas as pd;
#print(pd.__version__) #To get the version of pandas

#--------------Series-----------------# It is like dictionary single column of data, key-value pair

data = [1,24,52,2,5] #Converting list to pandas series
series = pd.Series(data, index = [0,1,2,3,4]) #Assigning indexes

#print(series) #Printing the whole series

series.loc[1] = 32 #Modifying the value
#print(series.loc[1]) #Printing the individual element by indexes

#print(series[(series >= 10) & (series <= 40)]) #Filtering based on the condition

calorie = {"Day1" : 1000, "Day2" : 2000, "Day3" : 3000} #Converting Dictionary into pandas
temp = pd.Series(calorie)

#print(temp)

# ---------------------Data Frames ------------------# It is like Excel or SQL Table (collection of series)
data = {"Name" : ["Barath", "Kumar", "bk1", "bk2"], "Age" : [18,20,14,24]}

frame = pd.DataFrame(data,index = ["Emp1", "Emp2", "Emp3", "Emp4"])

#print(frame)

#print(frame.loc["Emp1"]) #Accessing indivdual items in frames

frame["Job"] = ["SDE", "DS", "AI/ML", "Analyst"] #Adding coloumn

#print(frame)


new_rows = pd.DataFrame({"Name" : ["bk3"], "Age" : [34]}, index = ["emp4"])
frame = pd.concat([frame,new_rows])

#print(frame)

# ------------------------Importing ---------------------#

df2 = pd.read_csv("text.csv")
#print(df2.to_string()) #To display everything
 
#Printing Coloumns
#print(df2["Name"].to_string())

#Printing Multiple Coloumns
#print(df2[["Name", "Height"]].to_string())

#Selection by row
#print(df2.loc[69]) 

#print(df2.iloc[0:10:2, 0:3]) #Multiple row selection

heavy = df2[(df2["Weight"] > 100) & (df2["Legendary"] == 1)]
#print(heavy.iloc[0:10, 0:3])

water = df2[df2["Type1"] == "Water"]
#print(water[["Type1", "Name"]])

#For whole data frame
#print(df2.sum(numeric_only= True))
#print(df2.mean(numeric_only= True))
#print(df2.var(numeric_only= True))

#For single coloumn
#print(df2["Weight"].sum(numeric_only= True))
#print(df2["Weight"].count())
#print(df2["Weight"].median(numeric_only= True))
#print(df2["Weight"].mode())

#Group by
#group = df2.groupby("Type1")
#print(group["Weight"].sum())

#-------------Data Cleaning----------------#
df2 = df2.drop(columns=["Legendary", "No"])

df2 = df2.fillna({"Type2" : "None"})

df2["Type1"] = df2["Type1"].replace({"Grass" : "GRASS"})

df2["Name"] = df2["Name"].str.lower();
print(df2.to_string())