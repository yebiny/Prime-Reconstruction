import sklearn
import copy
from sklearn import linear_model
import numpy as np
import matplotlib.pyplot as plt
import pickle

def save_dict(dic, save_path):
    with open(save_path,'wb') as fw:
        pickle.dump(dic, fw)
    
def load_dict(load_path):
    with open(load_path, 'rb') as fr:
        dic = pickle.load(fr)
    return dic


def split_data(x, y, n_regression):
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

    x_train, y_train = x[mask_train], y[mask_train]
    x_test, y_test = x[mask_test], y[mask_test]

    return x_train, y_train, x_test, y_test

def make_model(x_train, y_train):
    model = linear_model.LinearRegression()
    model.fit(x_train, y_train)
    return model

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



def start_analsysis_diffR(sub_list, load_path, corr_dict):

    for SUBJ in sub_list:

        print('[%s] self_all other_all self_sup other_sup self_enh other_enh'%SUBJ)
        if SUBJ in corr_dict: continue 

        corr_dict[SUBJ]=[[] for i in range(6)]
        
        x = np.load('%s/x_mask.npy'%load_path%SUBJ)
        y = np.load('%s/y_arr2.npy'%load_path%SUBJ)
        sup_mask = np.load('%s/sup_mask.npy'%load_path%SUBJ)
        enh_mask = np.load('%s/enh_mask.npy'%load_path%SUBJ)
        
        x_sup = x[:, sup_mask!=0]
        x_enh = x[:, enh_mask!=0]
        print(x.shape, x_sup.shape, x_enh.shape)


        for n_iter in range(10):
            # step 1 make regression model with (x, y)
            x_train, y_train, x_test, y_test = split_data(x, y, n_iter)
            model = make_model(x_train, y_train)
            y_pred = model.predict(x_test)
            corr, self_all, other_all = get_corr(y_test, y_pred)

            # step 2 make regression model with (x_sup, y)
            x_train, y_train, x_test, y_test = split_data(x_sup, y, n_iter)
            model = make_model(x_train, y_train)
            y_pred = model.predict(x_test)
            corr, self_sup, other_sup = get_corr(y_test, y_pred)

            # step 3 make regression model with (x_enh, y)
            x_train, y_train, x_test, y_test = split_data(x_enh, y, n_iter)
            model = make_model(x_train, y_train)
            y_pred = model.predict(x_test)
            corr, self_enh, other_enh = get_corr(y_test, y_pred)


            print('* %i :     %.3f    %.3f     %.3f    %.3f     %.3f    %.3f'
                  %(n_iter, self_all, other_all, self_sup, other_sup, self_enh, other_enh))
            for vi, v in enumerate([self_all, other_all, self_sup, other_sup, self_enh, other_enh]):
                corr_dict[SUBJ][vi].append(v)
                
    return corr_dict

def start_analsysis_diffR_rndSample(sub_list, load_path, corr_dict):

    def _get_rnd_sample(x_sup, x_enh):
        if x_sup.shape[1]<x_enh.shape[1]: return x_sup
        else:         
            mask_idx=np.random.choice([i for i in range(x_sup.shape[1])], x_enh.shape[1], replace=False)
            mask_idx.sort()
            mask=[]
            for idx in range(x_sup.shape[1]):
                if idx in mask_idx: mask.append(True)
                else: mask.append(False)

            x_rnd=x_sup[:,mask]

            return x_rnd

    for SUBJ in sub_list:

            print('[%s] self_all other_all self_sup other_sup self_enh other_enh'%SUBJ)
            if SUBJ in corr_dict: continue

            corr_dict[SUBJ]=[[] for i in range(6)]

            x = np.load('%s/x_mask.npy'%load_path%SUBJ)
            y = np.load('%s/y_arr2.npy'%load_path%SUBJ)
            sup_mask = np.load('%s/sup_mask.npy'%load_path%SUBJ)
            enh_mask = np.load('%s/enh_mask.npy'%load_path%SUBJ)

            x_sup = x[:, sup_mask!=0]
            x_enh = x[:, enh_mask!=0]

            x_sup_rnd = _get_rnd_sample(x_sup, x_enh)
            print(x.shape, x_sup_rnd.shape, x_enh.shape)
            
            for n_iter in range(10):
                # step 1 make regression model with (x, y)
                x_train, y_train, x_test, y_test = split_data(x, y, n_iter)
                model = make_model(x_train, y_train)
                y_pred = model.predict(x_test)
                corr, self_all, other_all = get_corr(y_test, y_pred)

                # step 2 make regression model with (x_sup_rnd, y)
                x_train, y_train, x_test, y_test = split_data(x_sup_rnd, y, n_iter)
                model = make_model(x_train, y_train)
                y_pred = model.predict(x_test)
                corr, self_sup_rnd, other_sup_rnd = get_corr(y_test, y_pred)

                # step 3 make regression model with (x_enh, y)
                x_train, y_train, x_test, y_test = split_data(x_enh, y, n_iter)
                model = make_model(x_train, y_train)
                y_pred = model.predict(x_test)
                corr, self_enh, other_enh = get_corr(y_test, y_pred)


                print('* %i :     %.3f    %.3f     %.3f    %.3f     %.3f    %.3f'
                      %(n_iter, self_all, other_all, self_sup_rnd, other_sup_rnd, self_enh, other_enh))
                for vi, v in enumerate([self_all, other_all, self_sup_rnd, other_sup_rnd, self_enh, other_enh]):
                    corr_dict[SUBJ][vi].append(v)

    return corr_dict
        

def hist_with_dict(dic, save=None):

    plt.figure(figsize=(12,5))
    mean_val=[0 for i in range(6)]
    c_list=['g','g','b','b','r','r']
    values=['self all', 'other all', 'self sup', 'other sup', 'self enh', 'other enh']
    for keyi, key in enumerate(dic.keys()):
        for vi, (val_name, val) in enumerate(zip(values, dic[key])):
            if vi%2==0:
                plt.plot([values[vi], values[vi+1]], [np.mean(val), np.mean(dic[key][vi+1]) ] 
                     , marker='.', c='grey', linewidth=0.2)
            mean_val[vi]+=(np.mean(val)/len(dic)) 
    
    for mi, mean in enumerate(mean_val):
        plt.bar(mi, mean, alpha=0.4, color=c_list[mi], width=0.7)
        if mi%2==0:
            plt.plot([mi, mi+1], [mean_val[mi], mean_val[mi+1]] 
             , marker='.', c=c_list[mi], linewidth=1)
    if save!=None:
        plt.savefig(save)
    plt.show()
