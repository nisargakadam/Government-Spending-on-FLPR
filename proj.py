

##GridSearch with Ridge 
import pandas as pd 
import numpy as np 
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Ridge
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.linear_model import Lasso
from sklearn.ensemble import GradientBoostingRegressor
from sklearn.model_selection import cross_val_score
import matplotlib.pyplot as plt
from sklearn.model_selection import GridSearchCV
from sklearn.linear_model import Ridge
from sklearn.metrics import mean_squared_error
from sklearn.metrics import make_scorer
from sklearn.model_selection import GridSearchCV
from sklearn.linear_model import Ridge
from sklearn.metrics import mean_squared_error
from sklearn.metrics import make_scorer
from sklearn.metrics import r2_score

df = pd.read_csv('/content/sample_data/dataset_df.csv')

y = df['flpr']
X = df.drop('flpr',  axis=1)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

##RIDGE WITH INDEPENDENT VARIABLE
param_grid = {'alpha': [.1, .5, .8] }


rdg = Ridge()
s = make_scorer(mean_squared_error)

g = GridSearchCV(rdg, param_grid, scoring=s, cv=6)
g.fit(X_train, y_train)
best = g.best_estimator_
best.coef_
print(best.coef_)
print("Best hyperparameters: ", g.best_params_)

print("Mean squared error: ", -g.best_score_)
y_pred = best.predict(X_test)

re = g.cv_results_

cvsc = np.sqrt(np.abs(-re['mean_test_score']))
varmse = np.var(cvsc)

print("Variance ", varmse)
print("r2 score:  ", r2_score(y_test, y_pred))

#plot predictions from our IV included model


plt.scatter(y_test, y_pred)
plt.plot([min(y_test), max(y_test)], [min(y_test), max(y_test)], '-', color="pink", lw=2)

plt.xlabel('Real Y Values')
plt.ylabel('Predicted Y Values')

plt.show()

##without IV 
X = df.drop('ss_gdp',  axis=1)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

param_grid = {'alpha': [.1, .5, .8] }
r = Ridge()
sco = make_scorer(mean_squared_error)

gs = GridSearchCV(r, param_grid, scoring=sco, cv=6)

gs.fit(X_train, y_train)

print("Best hyperparameters: ", gs.best_params_)
bestp = gs.best_estimator_
bestp.coef_
print(bestp.coef_)
ypredw = bestp.predict(X_test)
print("Mean squared error: ", -gs.best_score_)

print("r2 score:  ", r2_score(y_test, ypredw))

plt.scatter(y_test, ypredw)
plt.plot([min(y_test), max(y_test)], [min(y_test), max(y_test)], '--', color="pink", lw=2)

plt.xlabel('Real Y Values')
plt.ylabel('Predicted Y Values')

plt.show()
