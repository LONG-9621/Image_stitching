from skimage.color import gray2rgb
from skimage.io import imread, imsave
from os import listdir, mkdir
from os.path import isfile, join, exists
from skimage.util import compare_images
import numpy as np
import argparse


source = 'source_images'
answer = 'stitched_images'


def _parseArgs():
    parser = argparse.ArgumentParser()
    parser.add_argument('--file', type=str)

    args = parser.parse_args()

    return args.file


def compare(file):
    sImg = gray2rgb(imread(source + '/' + file))
    aImg = imread(answer + '/' + file)

    diff = compare_images(sImg, aImg, method='diff')

    if np.sum(diff) < 1e-7:
        print('Result is correct')
    else:
        print('See diff file for difference')
        imsave('diff.png', diff)


filename = _parseArgs()


if filename:
    compare(filename)
else:
    files = [f for f in listdir(source) if isfile(join(source, f))]
    for i in range(len(files)):
        file = files[i]
        print('\n\nCMP\t', i, '\t', file)
        compare(file)