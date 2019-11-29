# Stitching Images
### An algorithm written in R stitching 2 images assuming they have common fragment
![firstImage](https://sun9-28.userapi.com/c858436/v858436395/103972/HmAW7uoneEw.jpg)
![secondImage](https://sun9-48.userapi.com/c858436/v858436395/10397c/lxBMyBLQa00.jpg)


## Requirements to run the files
### Packages to install/import:
* R
  * RStudio (IDE)
  * png
  * readbitmap
  * rstudioapi

* Python
  * from skimage.color import gray2rgb
  * from skimage.io import imread, imsave
  * from os import listdir, mkdir
  * from os.path import isfile, join, exists
  * from skimage.util import compare_images
  * import numpy as np
  * import argparse
  
### Steps to take if you wish to test the algorithm on some dataset:
1. Clone the project
2. Populate folder "source_images" with initial images in bmp file format
3. Run the python script "split.py" - it will split images in two parts putting them in folders 'left' and 'right' correspondingly
4. Run the R script - it will stitch images and put them all in folder 'stitched_images'
5. If you want to compare images - run the python script "validate.py"

All stitched images are gonna be in 'stitched_images' folder

### Steps to take if you only want to stitch two parts of an image:
 1. Clone the project
 2. Populate folders 'left' and 'right' with images you want to stitch. In 'left' folder - put left part of images, in 'right' put right part of images
 3. Run the R script

All stitched images are gonna be in 'stitched_images' folder

## DO NOT EDIT FOLDER NAMES
