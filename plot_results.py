import matplotlib.pyplot as plt
import pandas as pd

def plot_recimg(model, x_data, save_dir=None, show='y'):
    org_img = x_data[:100]
    rec_img = model(x_data[:100], training=False)
    fig, ax = plt.subplots(6, 10, figsize=(20, 10))
    for i in range(10):
        for j in range(6):
            if j%2 ==0: img=org_img
            else: img=rec_img
            ax[j][i].set_axis_off()
            ax[j][i].imshow(img[10*(j//2)+i])

    if save_dir != None:
        plt.savefig('%s/recimg.png'%(save_dir))
        print('Save Image in %s'%(save_dir))
    if show == 'y':
        plt.show()

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
