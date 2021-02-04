import sklearn
from sklearn import linear_model
import numpy as np
def get_corr(y_test, y_pred):

    corr=[]
    self_sum, other_sum = 0, 0
    self_n, other_n = 0, 0
    for ti, y_t in enumerate(y_test):
        corr_row=[]
        for pi, y_p in enumerate(y_pred):
            co = np.corrcoef(y_t, y_p)[0][1]
            corr_row.append(co)
            if ti==pi: 
                #print(ti, pi, co)
                self_sum +=co
                self_n+=1
            else:
                other_sum +=co
                other_n+=1
        corr.append(corr_row)  
    corr = np.array(corr)
    self_corr = self_sum/self_n
    other_corr = other_sum/other_n
    
    return corr, self_corr, other_corr


def regression_get_corr(act_arr, lat_arr):

    corrs=[]
    selfs=[]
    others=[]

    for n_regression in range(10):
        mask_train = []
        mask_test = []
        for i in range(10):
            if i==n_regression: 
                w_train = [False for i in range(100)]
                w_test = [True for i in range(100)]
            else: 
                w_train = [True for i in range(100)]
                w_test = [False for i in range(100)]
            mask_train.extend(w_train)
            mask_test.extend(w_test)

        x_train, y_train = act_arr[mask_train], lat_arr[mask_train]
        x_test, y_test = act_arr[mask_test], lat_arr[mask_test]

        line_fitter = linear_model.LinearRegression()
        line_fitter.fit(x_train, y_train)
        y_pred = line_fitter.predict(x_test)


        corr, self_corr, other_corr = get_corr(y_test, y_pred)

        print(self_corr, other_corr)
        corrs.append(corr)
        selfs.append(self_corr)
        others.append(other_corr)
        
    return corrs, selfs, others
