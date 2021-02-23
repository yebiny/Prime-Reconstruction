import os
import numpy as np
from PIL import Image
import matplotlib.pyplot as plt
#from help_printing import *

DATA_PATH = './data/celeba'
split_size  = 20000

dataset = []
for path in os.listdir(DATA_PATH):
    if '.jpg' in path:
        dataset.append(os.path.join(DATA_PATH, path))
dataset_num = len(dataset)
print('* Number of target dataset : ', dataset_num)

split_num = int(dataset_num / split_size)

for i in range(split_num):
    init = split_size*i
    end  = init+split_size
    print('* Try %i : %i to %i images'%(i, init, end))
    split_dataset  = dataset[init:end]
    print('* Split_dataset',len(split_dataset), '!!')
    crop = (30, 55, 150, 175) #croping size for the image so that only the face at centre is obtained
    images = [np.array((Image.open(path).crop(crop)).resize((64,64))) for path in split_dataset]
    print('* Crop images') 
    images = (np.array(images)/127.5)-1
    print('* Norm images') 
    
    x_data = np.array(images)
    x_data.shape
    save_dir = 'data'
    save_name='celeba_%i'%(end)
    np.save('%s/%s'%(save_dir, save_name), x_data)
    print('* Save  images as ',save_name) 

