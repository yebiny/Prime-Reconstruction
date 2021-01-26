from scipy import io
import os, sys, glob

def make_phase1_onset_txt(onset_time, condition, output_dir, outfix='onset'):

    if os.path.isdir(output_dir)==False:
        os.mkdir(output_dir)
    
    fix_f_name="%s/%s_fix.txt"%(output_dir, outfix)
    fix_f = open(fix_f_name, 'w')
    stim_f_name="%s/%s_stim.txt"%(output_dir, outfix)
    stim_f = open(stim_f_name, 'w')
    
    idx = 0
    for t, c in zip(onset_time, condition):
        if c==1 or c==2:
            idx+=1
            f_name="%s/%s_train%i.txt"%(output_dir, outfix, idx)
            f = open(f_name, 'w')
            data = '%i    %i    %i'%(t-6, 1, 1)
            f.write(data)
            f.close()
        
        if c==4:
            data = '%i    %i    %i\n'%(t-6, 1, 1)
            fix_f.write(data)
        if c==1:
            data = '%i    %i    %i\n'%(t-6, 1, 1)
            stim_f.write(data)
                
     
    fix_f.close()
    stim_f.close()


SUBJ=sys.argv[1]

behavior_phase1_list=glob.glob('data/%s/behavior/*phase1*mat'%SUBJ)

for behavior_phase1 in behavior_phase1_list:
    
    behavior_file=io.loadmat(behavior_phase1)
    condition = behavior_file['designMat'][1]
    onset_time= behavior_file['designMat'][5]
    output_dir = behavior_phase1.replace('behavior/data_', 'design/').replace('.mat', '')
    
    print('* ', behavior_phase1, output_dir)
    make_phase1_onset_txt(onset_time, condition, output_dir)
