#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import numpy as np
import scipy.io as sio
import csv
import sys
from sklearn.linear_model import LinearRegression
from sklearn.linear_model import Ridge


def return_latent_arr(SUBJ, mask, inputType):
    
    csvFile='/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/gen_actPat/imgList_cocat_train.csv'%(SUBJ)
    #matfile='/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/gen_actPat/tstat_masked_pat_concat_train_mask%s.mat'%(SUBJ, mask)
    matfile='/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/gen_actPat/%s_masked_pat_concat_train_mask%s.mat'%(SUBJ, inputType, mask)
    print(csvFile)
    print(matfile)

    # Latent info for each image
    f_latent = np.load('/Users/ghootaekim/fMRI_analysis/primeRecon/latentSpace/f_latent.npy', allow_pickle=True)
    m_latent = np.load('/Users/ghootaekim/fMRI_analysis/primeRecon/latentSpace/m_latent.npy', allow_pickle=True)
    

    # Image for experiment
    imgCSV = open(csvFile, 'r')
    imgCSV = csv.reader(imgCSV)
    imgList = [name for name in imgCSV]
        
    theseLatent=[]
    for idx in range(len(imgList)):
        img_info = imgList[idx][0].split('/')[-2]
        img_name = imgList[idx][0].split('/')[-1]


        if img_info == 'female':
            latent = f_latent
        else: latent = m_latent

        thisLatent = latent[latent[:,0]==img_name][0][1][0]
        theseLatent.append(thisLatent)
   

    # Activation pattern from experiment      
    activMat = sio.loadmat(matfile)
    activArr = activMat['tstat_masked_pat_concat_train']
        
    theseActiv=[]
    for idx in range(len(activArr[0])):

        thisActiv = activArr[:,idx]
        theseActiv.append(thisActiv)
            
    return np.array(theseLatent), np.array(theseActiv)


SUBJ=sys.argv[1]
mask=sys.argv[2]
inputType=sys.argv[3]

lat, act = return_latent_arr(SUBJ, mask, inputType)
print(lat.shape)
print(act.shape)

mdic = {"train_lat": lat}
outputFile = '/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/regression/train_lat.mat'%(SUBJ)
sio.savemat(outputFile, mdic)

#mdic = {"train_act": act}
#outputFile = '/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/regression/train_act.mat'%(SUBJ)
#sio.savemat(outputFile, mdic)

nItem = 1000
nIntv = 100
nIter = int(nItem/nIntv)
alpha = 10000
regType_list = ['linear',  'ridge']

for it in range(nIter):
    print("======",it)
    x , y = act, lat
    j = it*nIntv

    for i in range(nIntv):
        x = np.delete(x, (j), axis=0)
        y = np.delete(y, (j), axis=0)
    
    
   
    print(x.shape, y.shape)
    for regType in regType_list:
        if regType == 0:
            line_fitter = LinearRegression()
        else:
            line_fitter = Ridge(alpha=1000)
            

        line_fitter.fit(x, y)
    
        W = line_fitter.coef_
        print(W.shape)
    
        mdic = {"train_w": W}
        outputFile = '/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/regression/train_reg_weights_mask%s_%s_%s_iter%i.mat'%(SUBJ, mask, inputType, regType, it+1)
        sio.savemat(outputFile, mdic)
        print("weight matrix is saved!")
    
    
        #mdic = {"train_lat": x}
        #outputFile = '/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/regression/train_act_iter%i.mat'%(SUBJ, it+1)
        #sio.savemat(outputFile, mdic)
    
    
    mdic = {"train_lat": y}
    outputFile = '/Users/ghootaekim/fMRI_analysis/primeRecon/subjects/%s/inter_output/regression/train_latent_iter%i.mat'%(SUBJ, it+1)
    sio.savemat(outputFile, mdic)
    print("latent space for training set is saved!")