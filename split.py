from os import listdir, mkdir
from os.path import isfile, join, exists
from skimage.io import imread, imsave
from skimage.color import gray2rgb
from random import randint

path = 'source_images'

files = [f for f in listdir(path) if isfile(join(path, f))]


if not exists('left'):
    mkdir('left')
if not exists('right'):
    mkdir('right')

for i in range(len(files)):
    file = files[i]

    img = imread(path + '/' + file)
    color = gray2rgb(img)
    w = color.shape[1]

    def p(n):
        return format(n / w * 100, "0.3f")

    splitPoint = randint(w // 10 * 2, w // 10 * 8)
    share = randint(w // 20, w // 10)

    print(i, '\t',  p(share), '\t',  p(splitPoint), p(
        splitPoint - share // 2), p(splitPoint + share // 2))

    left = color[:, :(splitPoint + share // 2)]
    imsave('left/'+file, left)

    right = color[:, (splitPoint - share // 2):]
    imsave('right/'+file, right)
