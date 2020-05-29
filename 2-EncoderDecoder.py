from help_printing import *
from Models import *
import os
import numpy as np
from tensorflow.keras.callbacks import ModelCheckpoint, CSVLogger, ReduceLROnPlateau
import matplotlib.pyplot as plt


data_path = ['./data/celeba_40.npy', './data/celeba_80.npy']
print('* Loading data from ', data_path)
x_data1 = np.load(data_path[0])
x_data2 = np.load(data_path[1])
x_data = np.concatenate((x_data1, x_data2))
print('* Dataset shape: ', x_data.shape)

from sklearn.model_selection import train_test_split
x_train, x_test = train_test_split(x_data, train_size = 0.9)
print('* Training data shape: ', x_train.shape)
print('* Test data shape : ', x_test.shape)

model= AE_1(x_data)
model.summary()

save_dir = 'results_AE/AE_1'
if_not_make(save_dir)
print('* Save path: ', save_dir)


model.compile(optimizer='adam', loss = 'mse')
epochs=5
for epoch in range(epochs):
    
    idx = len(os.listdir(save_dir))//2
    #set checkpointer and save model
    checkpointer = ModelCheckpoint(filepath=save_dir+'/model_%i.hdf5'%(idx), monitor = 'val_loss', verbose=1, save_best_only=True)
    # handle loss step
    reduce_lr = ReduceLROnPlateau(monitor='val_loss', factor=0.2, patience=5, min_lr=1e-5)
    # save loss and acc
    csv_logger = CSVLogger(save_dir+'/log_%i.csv'%(idx))
    
    model.fit(x_train, x_train,
            epochs=10, 
            batch_size=256,
            validation_data=(x_test, x_test),
            callbacks = [checkpointer, reduce_lr, csv_logger]  
           )

    rec_img = model.predict(x_test)
    fig, ax = plt.subplots(6, 10, figsize=(20, 10))
    for i in range(10):

        ax[0][i].set_axis_off()
        ax[1][i].set_axis_off()
        ax[2][i].set_axis_off()
        ax[3][i].set_axis_off()
        ax[4][i].set_axis_off()
        ax[5][i].set_axis_off()
        
        
        ax[0][i].imshow(x_test[i])
        ax[1][i].imshow(rec_img[i])   
        ax[2][i].imshow(x_test[i+10])
        ax[3][i].imshow(rec_img[i+10])
        ax[4][i].imshow(x_test[i+20])
        ax[5][i].imshow(rec_img[i+20])

    plt.savefig('%s/rec_img_%i.png'%(save_dir,epoch))
