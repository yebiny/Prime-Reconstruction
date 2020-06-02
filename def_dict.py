import os, sys

def plot_recimg(save_dir, epoch, show='n'):
    org_img = x_train[:100]
    rec_img = vae(x_train[:100], training=False)
    fig, ax = plt.subplots(6, 10, figsize=(20, 10))
    for i in range(10):
        for j in range(6):
            if j%2 ==0: img=org_img 
            else: img=rec_img
            ax[j][i].set_axis_off()
            ax[j][i].imshow(img[10*(j//2)+i])
    
    plt.savefig('%s/recimg_%i.png'%(save_dir,epoch))
    if show == 'y':
        plt.show()
    plt.close('all')

def if_not_exit(path):
	if not os.path.exists(path):
		print(path, 'is not exist.')
		exit()
		
def if_not_make(path):
	if not os.path.exists(path):
		os.makedirs(path)
