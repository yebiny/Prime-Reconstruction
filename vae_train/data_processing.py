import os
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
#from help_printing import *
import sys

DATA_PATH = sys.argv[1]
SAVE_NAME = sys.argv[2]

dataset = []
for path in os.listdir(DATA_PATH):
    if '.jpg' in path and '_' not in path:
        dataset.append(os.path.join(DATA_PATH, path))
dataset_num = len(dataset)
print('* Number of target dataset : ', dataset_num)

split_size  = 20000 
size = 64

split_num = int(dataset_num / split_size)
print(split_num)
for i in range(split_num):
    init = split_size*i
    end  = init+split_size
    print('* Try %i : %i to %i images'%(i, init, end))
    split_dataset  = dataset[init:end]
    print('* Split_dataset',len(split_dataset), '!!')
    
    crop = (30, 55, 150, 175) #croping size for the image so that only the face at centre is obtained
    images = [np.array((Image.open(path).crop(crop)).resize((size,size))) for path in split_dataset]
    print('* Crop images') 
    
    images = (np.array(images)/255)
    print('* Norm images') 
    
    x_data = np.array(images)
    np.save('%s_%i'%(SAVE_NAME, end), x_data)
    print('* Save  images as ',SAVE_NAME)

