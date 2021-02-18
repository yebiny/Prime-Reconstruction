# Analysys full


# Process
## 1. convert
## 2. reorient
## 3. bet
> bash start-process.sh [subject] [ IMA directory path ]

# Firstlevel-analysis
## 1. make design directory
## 2. rendering
## 3. feat
> bash start-firstlevel-glm [ subject ] [ phase ] 

# Secondlevel-analysis
## 1. rendering
## 2. feat
> bash start-secondlevel-glm [ subject  ] [ phase ]

# Trial-wise analysis
## 0. ROI
> bash gen_ROI.sh
## 1. rendering
> gen_trialWiseGLM_designFSF(RESULTS, DATA, SUBJ) -> matlab code
## 2. generate mask
## 3. feat
## 4. aling trial_wise
## 5. data generate
> bash start-trial-wise-glm.sh [ subject ]
