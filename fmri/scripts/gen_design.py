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

def make_phase2_onset_txt(onset_time, condition, output_dir, outfix='onset'):

    if os.path.isdir(output_dir)==False:
        os.mkdir(output_dir)

    init_f_name="%s/%s_init.txt"%(output_dir, outfix)
    init_f = open(init_f_name, 'w')
    rep_f_name="%s/%s_rep.txt"%(output_dir, outfix)
    rep_f = open(rep_f_name, 'w')

    for t, c in zip(onset_time, condition):
        if c==1:
            data = '%f    %i    %i\n'%(t-6, 1, 1)
            init_f.write(data)
            
        if c==2:
            data = '%f    %i    %i'%(t-6, 1, 1)
            rep_f.write(data)

    init_f.close()
    rep_f.close()

SUBJ=sys.argv[1]
excute_path='/Users/nibey/Desktop/WorkSpace/kBRI/faceRec/fmri'
behavior_phase1_list=glob.glob('%s/data/%s/behavior/*phase1*mat'%(excute_path, SUBJ))
behavior_phase2_list=glob.glob('%s/data/%s/behavior/*phase2*mat'%(excute_path, SUBJ))

for behavior_phase1 in behavior_phase1_list:
    
    behavior_file=io.loadmat(behavior_phase1)
    condition = behavior_file['designMat'][1]
    onset_time= behavior_file['designMat'][5]
    output_dir = behavior_phase1.replace('behavior/data_', 'design/').replace('.mat', '')
    
    print('* ', behavior_phase1, output_dir)
    make_phase1_onset_txt(onset_time, condition, output_dir)

for behavior_phase2 in behavior_phase2_list:
    behavior_file=io.loadmat(behavior_phase2)
    condition = behavior_file['designMat'][2]
    onset_time= behavior_file['designMat'][6]
    output_dir = behavior_phase2.replace('behavior/data_', 'design/').replace('.mat', '')
    
    print('* ', behavior_phase2, output_dir)
    make_phase2_onset_txt(onset_time, condition, output_dir)
