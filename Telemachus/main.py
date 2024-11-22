import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.linear_model import LinearRegression
from sklearn.svm import SVR
from sklearn.neighbors import KNeighborsRegressor
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import StandardScaler

# Load the CSV file into a DataFrame
df = pd.read_csv('sample_positions_no_headers.csv', sep='\s+', header=None)

# Set the column labels
df.columns = ['Xpos', 'Xcur', 'Xtrq', 'Ypos', 'Ycur', 'Ytrq', 'Zpos', 'Zcur', 'Ztrq', 'Wpos', 'Wcur', 'Wtrq', 'Ppos', 'Pcur', 'Ptrq', 'Rpos', 'Rcur', 'Rtrq']

# Check for missing values
if df.isnull().values.any():
    print("The data contains missing values. Please fill them in before proceeding.")
    exit()

# Convert scientific notation to normal notation
pd.set_option('display.float_format', '{:.6f}'.format)

# Calculate total torque
df['Total_trq'] = df[['Xtrq', 'Ytrq', 'Ztrq', 'Wtrq', 'Ptrq', 'Rtrq']].sum(axis=1)

# Define features and target
X = df[['Xcur', 'Xtrq', 'Ycur', 'Ytrq', 'Zcur', 'Ztrq', 'Wcur', 'Wtrq', 'Pcur', 'Ptrq', 'Rcur', 'Rtrq', 'Total_trq']]
y = df[['Xpos', 'Ypos', 'Zpos', 'Wpos', 'Ppos', 'Rpos']]

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Scale the data
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# RandomForest model
model = RandomForestRegressor(n_estimators=100, random_state=42)
model.fit(X_train_scaled, y_train)
y_pred = model.predict(X_test_scaled)
# mse = mean_squared_error(y_test, y_pred)
# print(f"RandomForest Mean Squared Error: {mse}")

# Linear Regression model
# linear_model = LinearRegression()
# linear_model.fit(X_train_scaled, y_train)
# y_pred_linear = linear_model.predict(X_test_scaled)
# mse_linear = mean_squared_error(y_test, y_pred_linear)
# print(f"Linear Regression Mean Squared Error: {mse_linear}")

# Support Vector Regression (SVR) model
# svr_model = SVR()
# svr_model.fit(X_train_scaled, y_train)
# y_pred_svr = svr_model.predict(X_test_scaled)
# mse_svr = mean_squared_error(y_test, y_pred_svr)
# print(f"Support Vector Regression Mean Squared Error: {mse_svr}")

# K-Nearest Neighbors (KNN) model
# knn_model = KNeighborsRegressor()
# knn_model.fit(X_train_scaled, y_train)
# y_pred_knn = knn_model.predict(X_test_scaled)
# mse_knn = mean_squared_error(y_test, y_pred_knn)
# print(f"K-Nearest Neighbors Mean Squared Error: {mse_knn}")

# Make predictions for the next position
next_position_pred = model.predict(X_test_scaled[:1])

# Save the predicted next position to a CSV file with each value in a new row
pd.DataFrame(next_position_pred.T).to_csv('predicted_next_position.csv', header=False, index=False)
