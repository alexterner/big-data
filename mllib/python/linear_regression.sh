import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import mean_squared_error
from math import sqrt

dataset = pd.read_csv("/Users/alexterner/Downloads/housing.csv")
print(dataset.head())

# -----------------------------------------------------------
# Split the data based on independent(x - house feteures)
# and dependant(y - house price) values
# -----------------------------------------------------------

x = dataset.iloc[:, 0:5].values
print(x)

y = dataset.iloc[:, 5:6].values
print(y)

# -----------------------------------------------------------
# Divide the complete dataset into training and test dataset
# -----------------------------------------------------------
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=1 / 3, random_state=1234)

# -----------------------------------------------------------
# Implement our classifier based on simple Linear Regression
# -----------------------------------------------------------

simple_linear_regression = LinearRegression()
simple_linear_regression.fit(x_train, y_train)

# -----------------------------------------------------------
# Evaluate your model
# -----------------------------------------------------------

# compare y_predict to y_test
y_predict = simple_linear_regression.predict(x_test)

# rmse - root mean square error
mse = mean_squared_error(y_test, y_predict)
print(sqrt(mse))

# predict based on 1 single value
y_predict = simple_linear_regression.predict([[79545.45857, 5.682861322, 7.009188143, 4.09, 23086.8005]])
print(y_predict)


