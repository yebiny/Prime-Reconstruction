import numpy as np
import scipy.io as sio
import csv
import nibabel as nib
import scipy
import matplotlib.pyplot as plt

class DataGenerator():
    def __init__(self, SUBJ, RESULTS_PATH, DATA_PATH, nRun=10, nStim=110):
       
        # SET PATH HERE
        path_run = '%s/%s/trial_wise/phase1_trialWiseGLM_train_run00.feat'%(RESULTS_PATH, SUBJ)
        path_tstat = 'stats/tstat00_mask1.nii.gz'
        path_behavior = '%s/%s/behavior/data_phase1_run00.mat'%(DATA_PATH, SUBJ)
        path_mask = '%s/%s/mask/mask1.nii'%(RESULTS_PATH, SUBJ)
        path_flat='scripts/f_latent.npy'
        path_mlat='scripts/m_latent.npy'
       
        
        # Get data from paths
        mask = nib.load(path_mask)
        self.mask = mask.get_fdata()
        self.f_lat = np.load(path_flat, allow_pickle=True)
        self.m_lat = np.load(path_mlat, allow_pickle=True)
        self.run_list=[path_run.replace('00', str(i)) for i in range(1, 1+nRun)]
        self.tstat_list=[path_tstat.replace('00', str(i)) for i in range(1, 1+nStim)]
        self.behavior_list=[path_behavior.replace('00', str(i)) for i in range(1, 1+nRun)]
                
    def get_info_list(self):

        info_list=[]
        for run, (r, b) in enumerate(zip(self.run_list, self.behavior_list)):
            mat = scipy.io.loadmat(b)
            condition=mat['designMat'][1]
            img_gender=mat['designMat'][2][condition<=2]
            img_idx=mat['designMat'][3][condition<=2]
            condition = condition[condition<=2]

            for idx, t in enumerate(self.tstat_list):
                if condition[idx]!=1: continue
                info =  [ [run+1, idx+1], '%s/%s'%(r, t), [int(img_gender[idx]), int(img_idx[idx])] ]
                info_list.append(info) 
        print("* number of infos: %i"%len(info_list) )
        print("* smaple info:")
        print(info_list[0])
        return info_list
    
    def get_latent(self, info_list):
    
        lat_list=[]
        for info in info_list:
            gender = info[2][0]
            idx = info[2][1]

            if gender==1: lat_map=self.f_lat 
            else: lat_map=self.m_lat

            lat = lat_map[:,1][idx-1][0]
            lat_list.append(lat)

        lat_arr = np.array(lat_list)
        return lat_arr
    
    def get_voxel(self, info_list):
        voxel_list = []
        for info in info_list:

            voxel_path = info[1]
            voxel=nib.load(voxel_path)
            voxel=voxel.get_fdata()
            voxel_list.append(voxel)
            
        return  np.array(voxel_list)
    
    def get_masked_voxel(self, voxel_arr):

        n_masked = len(voxel_arr[0][self.mask==1])
        voxel_masked=np.zeros((len(voxel_arr), n_masked))
        
        for i, v in enumerate(voxel_arr):
            v_masked = v[self.mask==1]
            voxel_masked[i]=v_masked
        
        return voxel_masked
    
