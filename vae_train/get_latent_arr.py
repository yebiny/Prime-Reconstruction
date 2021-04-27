import scipy
import scipy.io as sio
import glob
import numpy as np
from PIL import Image


def image_process(img_path):
    img_list = glob.glob(img_path)
    img_list.sort()
    img_name = [img.split('/')[-1] for img in img_list]
    images = [np.array((Image.open(img)).resize((64,64))) for img in img_list]
    images = np.array(images)/255
    x_data = np.array(images)
    print(x_data.shape)
    return x_data, img_name

PATH = '/Volumes/BPlus/primeRec/'
m_data, m_name = image_process('%s/vae_train/data/male/0*jpg'%PATH)
f_data, f_name = image_process('%s/vae_train/data/female/0*jpg'%PATH)


from build_models import *
builder = BuildModel((64,64,3), 1000, n_layers=3, dense_dim=1024)
encoder = builder.build_encoder()
decoder = builder.build_decoder()
model = VAE(encoder, decoder, (64,64,3))
model.load_weight('results/celeba_z1000/vae.h5')
