import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

def plot_gridimg(encoder, decoder, x_data, idx, zidx, xmin, xmax):
    fig, ax = plt.subplots(1, 10, figsize=(20, 20),
                             subplot_kw={'xticks': [], 'yticks': []})
    org_img = x_data[idx]
    z = encoder.predict(org_img.reshape(1,64,64,3))[2][0]
    print('* original z space: ', z[zidx])
    grid_x = np.linspace(xmin, xmax, 10)
    for i in range(10):
        z[zidx] = grid_x[i]
        rec_img = decoder.predict(z.reshape(1, z.shape[0]))
        ax[i].imshow(rec_img.reshape(64,64,3))
        ax[i].set_title('z%i : %f'%(zidx, z[zidx]))
    plt.show()

def plot_recimg(model, x_data, h, save_name=None, show='y'):
    h , w = h, 10
    fig, axes = plt.subplots(h, w, figsize=(w*2, h*2),
                         subplot_kw={'xticks': [], 'yticks': []})
    rec_img = model(x_data[:100])
    org_img = x_data[:100]
    for ax, i in zip(axes.flat, range(w*h)):
        idx = i//2
        if i%2 ==0: 
            img = org_img[idx]
            title = 'org %i'%(idx)
        else:
            img = rec_img[idx]
            title = 'rec %i'%(idx)
        ax.imshow(img)
        ax.set_title(title)
    if save_name !=None:
        plt.savefig(save_name)
    if show =='y':
        plt.show()
    plt.close('all')

def plot_loss(save_dir):
    log = pd.read_csv(save_dir+'/log.csv')
    loss = log['loss']
    val_loss = log['val_loss']

    plt.figure(figsize=(6,4))
    plt.plot(loss, 'o-', c='skyblue', label='loss')
    plt.plot(val_loss, 'o-', c='hotpink', label='val_loss')
    plt.legend()
    plt.xlabel('epoch')
    plt.ylabel('loss')
    plt.title('Plot loss')

    plt.savefig(save_dir+'/loss.png')
    plt.show()
