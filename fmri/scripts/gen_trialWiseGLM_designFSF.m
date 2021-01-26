%generating design for GLM
function gen_trialWiseGLM_designFSF(pwd, subj)


%%
nEV = [110 10];
trainTest_list = {'train', 'test'};

nifti=[pwd '/results/' subj '/2-reorient'];
structure_image=[pwd '/results/' subj '/3-bet/t1_mprage_brain.nii.gz'];
output_dir=[pwd '/results/' subj '/trial_wise'];
design=[pwd '/data/' subj '/design'];
%%

for run = 1:10
    
    xRun = num2str(run);
    
    
    for trainTest = 1:length(trainTest_list)
        fileName = [output_dir '/phase1_trialWiseGLM_' trainTest_list{trainTest} '_run' num2str(run) '.fsf'];
        fid = fopen(fileName, 'w');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# FEAT version number');
        fprintf(fid, '%s\n', 'set fmri(version) 6.00');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Are we in MELODIC?');
        fprintf(fid, '%s\n', 'set fmri(inmelodic) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Analysis level');
        fprintf(fid, '%s\n', '# 1 : First-level analysis');
        fprintf(fid, '%s\n', '# 2 : Higher-level analysis');
        fprintf(fid, '%s\n', 'set fmri(level) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Which stages to run');
        fprintf(fid, '%s\n', '# 0 : No first-level analysis (registration and/or group stats only)');
        fprintf(fid, '%s\n', '# 7 : Full first-level analysis');
        fprintf(fid, '%s\n', '# 1 : Pre-processing');
        fprintf(fid, '%s\n', '# 2 : Statistics');
        fprintf(fid, '%s\n', 'set fmri(analysis) 7');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Use relative filenames');
        fprintf(fid, '%s\n', 'set fmri(relative_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Balloon help');
        fprintf(fid, '%s\n', 'set fmri(help_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Run Featwatcher');
        fprintf(fid, '%s\n', 'set fmri(featwatcher_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Cleanup first-level standard-space images');
        fprintf(fid, '%s\n', 'set fmri(sscleanup_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Output directory');
        xStr = [output_dir '/phase1_trialWiseGLM_' trainTest_list{trainTest} '_run' num2str(run)];
        fprintf(fid, '%s\n', ['set fmri(outputdir) "' xStr '"']);
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# TR(s)');
        fprintf(fid, '%s\n', 'set fmri(tr) 1.5');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Total volumes');
        fprintf(fid, '%s\n', 'set fmri(npts) 320');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Delete volumes');
        fprintf(fid, '%s\n', 'set fmri(ndelete) 4');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Perfusion tag/control order');
        fprintf(fid, '%s\n', 'set fmri(tagfirst) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Number of first-level analyses');
        fprintf(fid, '%s\n', 'set fmri(multiple) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Higher-level input type');
        fprintf(fid, '%s\n', '# 1 : Inputs are lower-level FEAT directories');
        fprintf(fid, '%s\n', '# 2 : Inputs are cope images from FEAT directories');
        fprintf(fid, '%s\n', 'set fmri(inputtype) 2');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Carry out pre-stats processing?');
        fprintf(fid, '%s\n', 'set fmri(filtering_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Brain/background threshold, %');
        fprintf(fid, '%s\n', 'set fmri(brain_thresh) 10');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Critical z for design efficiency calculation');
        fprintf(fid, '%s\n', 'set fmri(critical_z) 5.3');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Noise level');
        fprintf(fid, '%s\n', 'set fmri(noise) 0.66');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Noise AR(1)');
        fprintf(fid, '%s\n', 'set fmri(noisear) 0.34');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Motion correction');
        fprintf(fid, '%s\n', '# 0 : None');
        fprintf(fid, '%s\n', '# 1 : MCFLIRT');
        fprintf(fid, '%s\n', 'set fmri(mc) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Spin-history (currently obsolete)');
        fprintf(fid, '%s\n', 'set fmri(sh_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# B0 fieldmap unwarping?');
        fprintf(fid, '%s\n', 'set fmri(regunwarp_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# GDC Test');
        fprintf(fid, '%s\n', 'set fmri(gdc) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# EPI dwell time (ms)');
        fprintf(fid, '%s\n', 'set fmri(dwell) 0.7');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# EPI TE (ms)');
        fprintf(fid, '%s\n', 'set fmri(te) 35');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# % Signal loss threshold');
        fprintf(fid, '%s\n', 'set fmri(signallossthresh) 10');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Unwarp direction');
        fprintf(fid, '%s\n', 'set fmri(unwarp_dir) y-');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Slice timing correction');
        fprintf(fid, '%s\n', '# 0 : None');
        fprintf(fid, '%s\n', '# 1 : Regular up (0, 1, 2, 3, ...)');
        fprintf(fid, '%s\n', '# 2 : Regular down');
        fprintf(fid, '%s\n', '# 3 : Use slice order file');
        fprintf(fid, '%s\n', '# 4 : Use slice timings file');
        fprintf(fid, '%s\n', '# 5 : Interleaved (0, 2, 4 ... 1, 3, 5 ... )');
        fprintf(fid, '%s\n', 'set fmri(st) 5');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Slice timings file');
        fprintf(fid, '%s\n', 'set fmri(st_file) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# BET brain extraction');
        fprintf(fid, '%s\n', 'set fmri(bet_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Spatial smoothing FWHM (mm)');
        fprintf(fid, '%s\n', 'set fmri(smooth) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Intensity normalization');
        fprintf(fid, '%s\n', 'set fmri(norm_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Perfusion subtraction');
        fprintf(fid, '%s\n', 'set fmri(perfsub_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Highpass temporal filtering');
        fprintf(fid, '%s\n', 'set fmri(temphp_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Lowpass temporal filtering');
        fprintf(fid, '%s\n', 'set fmri(templp_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# MELODIC ICA data exploration');
        fprintf(fid, '%s\n', 'set fmri(melodic_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Carry out main stats?');
        fprintf(fid, '%s\n', 'set fmri(stats_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Carry out prewhitening?');
        fprintf(fid, '%s\n', 'set fmri(prewhiten_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Add motion parameters to model');
        fprintf(fid, '%s\n', '# 0 : No');
        fprintf(fid, '%s\n', '# 1 : Yes');
        fprintf(fid, '%s\n', 'set fmri(motionevs) 0');
        fprintf(fid, '%s\n', 'set fmri(motionevsbeta) ""');
        fprintf(fid, '%s\n', 'set fmri(scriptevsbeta) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Robust outlier detection in FLAME?');
        fprintf(fid, '%s\n', 'set fmri(robust_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Higher-level modelling');
        fprintf(fid, '%s\n', '# 3 : Fixed effects');
        fprintf(fid, '%s\n', '# 0 : Mixed Effects: Simple OLS');
        fprintf(fid, '%s\n', '# 2 : Mixed Effects: FLAME 1');
        fprintf(fid, '%s\n', '# 1 : Mixed Effects: FLAME 1+2');
        fprintf(fid, '%s\n', 'set fmri(mixed_yn) 2');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Higher-level permutations');
        fprintf(fid, '%s\n', 'set fmri(randomisePermutations) 5000');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Number of EVs');
        fprintf(fid, '%s\n', ['set fmri(evs_orig) ' num2str(nEV(trainTest))]);
        fprintf(fid, '%s\n', ['set fmri(evs_real) ' num2str(nEV(trainTest))]);
        fprintf(fid, '%s\n', 'set fmri(evs_vox) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Number of contrasts');
        fprintf(fid, '%s\n', ['set fmri(ncon_orig) ' num2str(nEV(trainTest))]);
        fprintf(fid, '%s\n', ['set fmri(ncon_real) ' num2str(nEV(trainTest))]);
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Number of F-tests');
        fprintf(fid, '%s\n', 'set fmri(nftests_orig) 0');
        fprintf(fid, '%s\n', 'set fmri(nftests_real) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Add constant column to design matrix? (obsolete)');
        fprintf(fid, '%s\n', 'set fmri(constcol) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Carry out post-stats steps?');
        fprintf(fid, '%s\n', 'set fmri(poststats_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Pre-threshold masking?');
        fprintf(fid, '%s\n', 'set fmri(threshmask) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Thresholding');
        fprintf(fid, '%s\n', '# 0 : None');
        fprintf(fid, '%s\n', '# 1 : Uncorrected');
        fprintf(fid, '%s\n', '# 2 : Voxel');
        fprintf(fid, '%s\n', '# 3 : Cluster');
        fprintf(fid, '%s\n', 'set fmri(thresh) 3');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# P threshold');
        fprintf(fid, '%s\n', 'set fmri(prob_thresh) 0.05');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Z threshold');
        fprintf(fid, '%s\n', 'set fmri(z_thresh) 3.1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Z min/max for colour rendering');
        fprintf(fid, '%s\n', '# 0 : Use actual Z min/max');
        fprintf(fid, '%s\n', '# 1 : Use preset Z min/max');
        fprintf(fid, '%s\n', 'set fmri(zdisplay) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Z min in colour rendering');
        fprintf(fid, '%s\n', 'set fmri(zmin) 2');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Z max in colour rendering');
        fprintf(fid, '%s\n', 'set fmri(zmax) 8');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Colour rendering type');
        fprintf(fid, '%s\n', '# 0 : Solid blobs');
        fprintf(fid, '%s\n', '# 1 : Transparent blobs');
        fprintf(fid, '%s\n', 'set fmri(rendertype) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Background image for higher-level stats overlays');
        fprintf(fid, '%s\n', '# 1 : Mean highres');
        fprintf(fid, '%s\n', '# 2 : First highres');
        fprintf(fid, '%s\n', '# 3 : Mean functional');
        fprintf(fid, '%s\n', '# 4 : First functional');
        fprintf(fid, '%s\n', '# 5 : Standard space template');
        fprintf(fid, '%s\n', 'set fmri(bgimage) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Create time series plots');
        fprintf(fid, '%s\n', 'set fmri(tsplot_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Registration to initial structural');
        fprintf(fid, '%s\n', 'set fmri(reginitial_highres_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Search space for registration to initial structural');
        fprintf(fid, '%s\n', '# 0   : No search');
        fprintf(fid, '%s\n', '# 90  : Normal search');
        fprintf(fid, '%s\n', '# 180 : Full search');
        fprintf(fid, '%s\n', 'set fmri(reginitial_highres_search) 90');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Degrees of Freedom for registration to initial structural');
        fprintf(fid, '%s\n', 'set fmri(reginitial_highres_dof) 3');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Registration to main structural');
        fprintf(fid, '%s\n', 'set fmri(reghighres_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Search space for registration to main structural');
        fprintf(fid, '%s\n', '# 0   : No search');
        fprintf(fid, '%s\n', '# 90  : Normal search');
        fprintf(fid, '%s\n', '# 180 : Full search');
        fprintf(fid, '%s\n', 'set fmri(reghighres_search) 90');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Degrees of Freedom for registration to main structural');
        fprintf(fid, '%s\n', 'set fmri(reghighres_dof) 6');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Registration to standard image?');
        fprintf(fid, '%s\n', 'set fmri(regstandard_yn) 1');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Use alternate reference images?');
        fprintf(fid, '%s\n', 'set fmri(alternateReference_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Standard image');
        fprintf(fid, '%s\n', 'set fmri(regstandard) "/usr/local/fsl/data/standard/MNI152_T1_2mm_brain"');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Search space for registration to standard space');
        fprintf(fid, '%s\n', '# 0   : No search');
        fprintf(fid, '%s\n', '# 90  : Normal search');
        fprintf(fid, '%s\n', '# 180 : Full search');
        fprintf(fid, '%s\n', 'set fmri(regstandard_search) 90');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Degrees of Freedom for registration to standard space');
        fprintf(fid, '%s\n', 'set fmri(regstandard_dof) 12');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Do nonlinear registration from structural to standard space?');
        fprintf(fid, '%s\n', 'set fmri(regstandard_nonlinear_yn) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Control nonlinear warp field resolution');
        fprintf(fid, '%s\n', 'set fmri(regstandard_nonlinear_warpres) 10 ');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# High pass filter cutoff');
        fprintf(fid, '%s\n', 'set fmri(paradigm_hp) 128');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Total voxels');
        fprintf(fid, '%s\n', 'set fmri(totalVoxels) 35389440');
        fprintf(fid, '\n');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Number of lower-level copes feeding into higher-level analysis');
        fprintf(fid, '%s\n', 'set fmri(ncopeinputs) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# 4D AVW data or FEAT directory (1)');
        xStr = [ nifti '/phase1_run' xRun ];
        fprintf(fid, '%s\n', ['set feat_files(1) "' xStr '"']);
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Add confound EVs text file');
        fprintf(fid, '%s\n', 'set fmri(confoundevs) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Subject''s structural image for analysis 1');
        xStr = ( structure_image );
        fprintf(fid, '%s\n', ['set highres_files(1) "' xStr '"']);
        fprintf(fid, '\n');
        
        for ii = 1:nEV(trainTest)
            xEV = ['EV ' num2str(ii)];
            fprintf(fid, '%s\n', ['# ' xEV ' title']);
            xStr = ['set fmri(evtitle' num2str(ii) ') "onset_' trainTest_list{trainTest} num2str(ii) '"'];
            fprintf(fid, '%s\n', xStr);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Basic waveform shape (EV ' num2str(ii) ')']);
            fprintf(fid, '%s\n', '# 0 : Square');
            fprintf(fid, '%s\n', '# 1 : Sinusoid');
            fprintf(fid, '%s\n', '# 2 : Custom (1 entry per volume)');
            fprintf(fid, '%s\n', '# 3 : Custom (3 column format)');
            fprintf(fid, '%s\n', '# 4 : Interaction');
            fprintf(fid, '%s\n', '# 10 : Empty (all zeros)');
            fprintf(fid, '%s\n', ['set fmri(shape' num2str(ii) ') 3']);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Convolution (EV ' num2str(ii) ')']);
            fprintf(fid, '%s\n', '# 0 : None');
            fprintf(fid, '%s\n', '# 1 : Gaussian');
            fprintf(fid, '%s\n', '# 2 : Gamma');
            fprintf(fid, '%s\n', '# 3 : Double-Gamma HRF');
            fprintf(fid, '%s\n', '# 4 : Gamma basis functions');
            fprintf(fid, '%s\n', '# 5 : Sine basis functions');
            fprintf(fid, '%s\n', '# 6 : FIR basis functions');
            fprintf(fid, '%s\n', '# 8 : Alternate Double-Gamma');
            fprintf(fid, '%s\n', ['set fmri(convolve' num2str(ii) ') 3']);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Convolve phase (EV ' num2str(ii) ')']);
            fprintf(fid, '%s\n', ['set fmri(convolve_phase' num2str(ii) ') 0']);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Apply temporal filtering (EV ' num2str(ii) ')']);
            fprintf(fid, '%s\n', ['set fmri(tempfilt_yn' num2str(ii) ') 0']);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Add temporal derivative (EV ' num2str(ii) ')']);
            fprintf(fid, '%s\n', ['set fmri(deriv_yn' num2str(ii) ') 0']);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Custom EV file (EV ' num2str(ii) ')']);
            xStr = ['set fmri(custom' num2str(ii) ') "' design '/phase1_run' xRun '/onset_' trainTest_list{trainTest} num2str(ii) '.txt"'];
            fprintf(fid, '%s\n', xStr);
            fprintf(fid, '\n');
            
            for jj = 1:nEV(trainTest)+1
                xStr = ['# Orthogonalise EV ' num2str(ii) ' wrt EV ' num2str(jj-1)];
                fprintf(fid, '%s\n', xStr);
                fprintf(fid, '%s\n', ['set fmri(ortho' num2str(ii) '.' num2str(jj-1) ') 0']);
                fprintf(fid, '\n');
            end%for jj
        end%for ii
        
        
        fprintf(fid, '%s\n', '# Contrast & F-tests mode');
        fprintf(fid, '%s\n', '# real : control real EVs');
        fprintf(fid, '%s\n', '# orig : control original EVs');
        fprintf(fid, '%s\n', 'set fmri(con_mode_old) orig');
        fprintf(fid, '%s\n', 'set fmri(con_mode) orig');
        fprintf(fid, '\n');
        
        for ii = 1:nEV(trainTest)
            fprintf(fid, '%s\n', ['# Display images for contrast_real ' num2str(ii)]);
            fprintf(fid, '%s\n', ['set fmri(conpic_real.' num2str(ii) ') 1']);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Title for contrast_real ' num2str(ii)]);
            fprintf(fid, '%s\n', ['set fmri(conname_real.' num2str(ii) ') "onset_' trainTest_list{trainTest} num2str(ii) '"']);
            fprintf(fid, '\n');
            
            for jj = 1:nEV(trainTest)
                fprintf(fid, '%s\n', ['# Real contrast_real vector ' num2str(ii) ' element ' num2str(jj)]);
                if ii == jj
                    fprintf(fid, '%s\n', ['set fmri(con_real' num2str(ii) '.' num2str(jj) ') 1.0' ]);
                else
                    fprintf(fid, '%s\n', ['set fmri(con_real' num2str(ii) '.' num2str(jj) ') 0' ]);
                end%for ii
                fprintf(fid, '\n');
            end%for jj
        end%for ii
        
        for ii = 1:nEV(trainTest)
            fprintf(fid, '%s\n', ['# Display images for contrast_orig ' num2str(ii)]);
            fprintf(fid, '%s\n', ['set fmri(conpic_orig.' num2str(ii) ') 1']);
            fprintf(fid, '\n');
            
            fprintf(fid, '%s\n', ['# Title for contrast_orig ' num2str(ii)]);
            fprintf(fid, '%s\n', ['set fmri(conname_orig.' num2str(ii) ') "onset_' trainTest_list{trainTest} num2str(ii) '"']);
            fprintf(fid, '\n');
            
            for jj = 1:nEV(trainTest)
                fprintf(fid, '%s\n', ['# Real contrast_orig vector ' num2str(ii) ' element ' num2str(jj)]);
                if ii == jj
                    fprintf(fid, '%s\n', ['set fmri(con_orig' num2str(ii) '.' num2str(jj) ') 1.0' ]);
                else
                    fprintf(fid, '%s\n', ['set fmri(con_orig' num2str(ii) '.' num2str(jj) ') 0' ]);
                end%for ii
                fprintf(fid, '\n');
            end%for jj
        end%for ii
        
        fprintf(fid, '%s\n', '# Contrast masking - use >0 instead of thresholding?');
        fprintf(fid, '%s\n', 'set fmri(conmask_zerothresh_yn) 0');
        fprintf(fid, '\n');
        
        for ii = 1:nEV(trainTest)
            others = setdiff(1:nEV(trainTest), ii);
            for jj = 1:length(others)
                fprintf(fid, '%s\n', ['# Mask real contrast/F-test ' num2str(ii) ' with real contrast/F-test ' num2str(others(jj)) '?']);
                fprintf(fid, '%s\n', ['set fmri(conmask' num2str(ii) '_' num2str(others(jj)) ') 0' ]);
                fprintf(fid, '\n');
            end%for jj
        end%for ii
        
        fprintf(fid, '%s\n', '# Do contrast masking at all?');
        fprintf(fid, '%s\n', 'set fmri(conmask1_1) 0');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '##########################################################');
        fprintf(fid, '%s\n', '# Now options that don''t appear in the GUI');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Alternative (to BETting) mask image');
        fprintf(fid, '%s\n', 'set fmri(alternative_mask) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Initial structural space registration initialisation transform');
        fprintf(fid, '%s\n', 'set fmri(init_initial_highres) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Structural space registration initialisation transform');
        fprintf(fid, '%s\n', 'set fmri(init_highres) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# Standard space registration initialisation transform');
        fprintf(fid, '%s\n', 'set fmri(init_standard) ""');
        fprintf(fid, '\n');
        
        fprintf(fid, '%s\n', '# For full FEAT analysis: overwrite existing .feat output dir?');
        fprintf(fid, '%s\n', 'set fmri(overwrite_yn) 0');
    end%for trainTest
end%for run
     

