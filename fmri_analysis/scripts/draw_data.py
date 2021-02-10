import matplotlib.pyplot as plt
import seaborn as sns

def draw_imgs(imgs, save=None):
    
    for j in range(3):
        r = imgs.shape[j]
        plt.figure(figsize=(20,6))
        for i in range(1, r//10):
            idx = 10*i
            plt.subplot(3, r//10, j*(r//10)+i+1)
            plt.title('axis-%i: %i'%(j, idx))
            if j==0:
                img = imgs[idx,:,:]
            elif j==1:        
                img = imgs[:,idx,:]      
            elif j==2:
                img = imgs[:,:,idx]
            plt.imshow(img, cmap='gray')

    if save!=None:
        plt.savefig(save)
    plt.show()

def cut_data(data):
    cut_data = data[10:80, 10:60, 10:60]
    return cut_data

def hist_value(voxel):
    v_concat=np.concatenate(voxel)
    v_concat=np.concatenate(v_concat)
    plt.hist(v_concat, bins=50, log=True)
    plt.show()

def draw_heatmap(data):
    plt.figure(figsize=(15,12))
    ax = sns.heatmap(data = data,
                     annot=True,
                     #fmt = '.2f', linewidths=.5,
                     cmap='Blues')
    b, t = ax.get_ylim()
    ax.set_ylim(b+0.5, t-0.5)
    plt.show()
