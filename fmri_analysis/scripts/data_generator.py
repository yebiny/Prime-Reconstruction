import os,sys, argparse
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
        path_flat='scripts/f_latent_z1000.npy'
        path_mlat='scripts/m_latent_z1000.npy'
       
        
        # Get data from paths
        mask = nib.load(path_mask)
        self.mask = mask.get_fdata()
        self.f_lat = np.load(path_flat, allow_pickle=True)
        self.m_lat = np.load(path_mlat, allow_pickle=True)
        self.run_list=[path_run.replace('00', str(i)) for i in range(1, 1+nRun)]
        self.tstat_list=[path_tstat.replace('00', str(i)) for i in range(1, 1+nStim)]
        self.behavior_list=[path_behavior.replace('00', str(i)) for i in range(1, 1+nRun)]
        self.mask_dir = '%s/%s/mask/'%(RESULTS_PATH, SUBJ)

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
        print(info_list[0])
        return info_list
    
    def get_latent(self, info_list):
    
        lat_list=[]
        gender_list=[]

        for info in info_list:
            gender = info[2][0]
            idx = info[2][1]

            if gender==1: 
                lat_map=self.f_lat
                gender_list.append(1)
            else: 
                lat_map=self.m_lat
                gender_list.append(0)

            lat = lat_map[:,1][idx-1][0]
            lat_list.append(lat)

        lat_arr = np.array(lat_list)
        gender_arr = np.array(gender_list)
        return lat_arr, gender_arr
    
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

        
    def get_sup_enh_mask(self, sup_mask, enh_mask):
    
        sup = nib.load(sup_mask)
        sup = sup.get_fdata()
        enh = nib.load(enh_mask)
        enh = enh.get_fdata()
    
        mask_sup = sup[self.mask==1]
        mask_enh = enh[self.mask==1]
        
        return mask_sup, mask_enh


def parse_args():
    opt = argparse.ArgumentParser(description="==== Data generator for regression  ====")
    opt.add_argument(dest='DATA', type=str, help=': DATA')
    opt.add_argument(dest='RESULTS', type=str, help=': RESULTS')
    opt.add_argument(dest='SUP_MASK', type=str, help=': supression mask')
    opt.add_argument(dest='ENH_MASK', type=str, help=': enhancement mask')
    opt.add_argument(dest='SUBJ_LIST', nargs='*', help='preprocessing as <*>')
    args = opt.parse_args()

    return args


def main():

    args=parse_args()
    for subj in args.SUBJ_LIST:
        save_path = '%s/%s/regression_z1000_mask1/'%(args.RESULTS, subj)
        if not os.path.exists(save_path): os.makedirs(save_path)

        dg = DataGenerator(subj, args.RESULTS, args.DATA)
        info_list = dg.get_info_list()
        latent, gender = dg.get_latent(info_list)
        voxel = dg.get_voxel(info_list)
    
        voxel_masked = dg.get_masked_voxel(voxel)    
        sup_mask, enh_mask = dg.get_sup_enh_mask( '%s/%s'%(dg.mask_dir,args.SUP_MASK)
                                                , '%s/%s'%(dg.mask_dir,args.ENH_MASK))
        
        np.save('%s/voxel_masked'%save_path, voxel_masked)
        np.save('%s/enh_mask'%save_path, enh_mask)
        np.save('%s/sup_mask'%save_path, sup_mask)
        np.save('%s/latent'%save_path, latent) 
        np.save('%s/gender'%save_path, gender) 
        print('* %s :'%subj, voxel_masked.shape, latent.shape, len(enh_mask[enh_mask==1]), len(sup_mask[sup_mask==1]))

if __name__=='__main__':
    main()
