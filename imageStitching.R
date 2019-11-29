library(png)
library(readbitmap)

# Here we specify working directory (full path) where folders 'source_images', left', 'right', 'stitched_images'
# and files 'imageStitching.R', 'split.py', 'validate.py' are located.
# MUST DO!!!
workingDirectory <- '/Users/nihad/Desktop/R/images'
setwd(workingDirectory)
leftImagesPath <- paste(workingDirectory, "/left/", sep="")
rightImagesPath <- paste(workingDirectory, "/right/", sep="")
sourceImagesPath <- paste(workingDirectory, "/source_images/", sep="")
stitchedImagesPath <- paste(workingDirectory, "/stitched_images/", sep="")







# Trying to find a match for 3 pixels (uppermost, middle, bottommost) of some column
# of a first image to corresponding 3 pixels of some column of a second image.
# If output (xPosition) != 0, then it is found. If 0, then it isn't.
find_X_positionMatch <- function(leftImage, rightImage, leftImageWidth, height) {
  midHeight <- height%/%2
  for(firstImageCurrentX in 1:leftImageWidth) {
    if(leftImage[1, firstImageCurrentX, ] == rightImage[1, 1, ] & leftImage[midHeight, firstImageCurrentX, ] == rightImage[midHeight, 1, ] & leftImage[height, firstImageCurrentX, ] == rightImage[height, 1, ]){
      stop <- TRUE
      for(i in 1:(leftImageWidth-firstImageCurrentX)){
        if(leftImage[1, firstImageCurrentX+i, ] != rightImage[1, 1+i, ] | leftImage[midHeight, firstImageCurrentX+i, ] != rightImage[midHeight, 1+i, ] | leftImage[height, firstImageCurrentX+i, ] != rightImage[height, 1+i, ]){
          stop <- FALSE
          break
        }
      }
      if(stop){
        return (firstImageCurrentX)
      }
    }
  }
  return (0)
}


stitchImages <- function(imgName1, imgName2){
  leftImage <- read.bitmap(paste(leftImagesPath, imgName1, sep=""))
  rightImage <- read.bitmap(paste(rightImagesPath, imgName2, sep=""))
  leftImageWidth <- dim(leftImage)[2]
  rightImageWidth <- dim(rightImage)[2]
  height <- dim(leftImage)[1]
  
  # Algorithm starts
  matchedXstitchPosition <- 0
  matchedXstitchPosition <- find_X_positionMatch(leftImage, rightImage, leftImageWidth, height)
  
  if (matchedXstitchPosition != 0) {
    newWidth <- matchedXstitchPosition+rightImageWidth-1
    resultOfStitching <- sample(0, newWidth*height*3, replace = TRUE)
    dim(resultOfStitching) <- c(height, newWidth, 3)
    resultOfStitching[1:height, 1:(matchedXstitchPosition-1), ] <- leftImage[1:height, 1:(matchedXstitchPosition-1), ]
    resultOfStitching[1:height, matchedXstitchPosition:newWidth, ] <- rightImage[1:height, 1:rightImageWidth, ]
    resultOfStitching <- resultOfStitching/255
    
    writePNG(resultOfStitching, paste(stitchedImagesPath, imgName1, sep =""))
  } else {
    # In case if two images have no common border, but were just divided in two separate parts
    # and stitching them together one after another could make a sense
    print("Unfortunately stitching cannot be done.")
    print("Maybe putting them one after another will make a sense.")
    newWidth <- firstImageWidth+secondImageWidth
    simpleStitch <- sample(0, newWidth*height*3,replace = TRUE)
    dim(simpleStitch) <- c(height, newWidth, 3)
    simpleStitch[1:height, 1:firstImageWidth, ] <- firstImage[1:height, 1:firstImageWidth, ]
    simpleStitch[1:height, (firstImageWidth+1):newWidth, ] <- secondImage[1:height, 1:secondImageWidth, ]
    
    
    writePNG(simpleStitch, paste(stitchedImagesPath, imgName1, sep =""))
  }
}

#---------------------------- MAIN ---------------------------------------------------------------------#
# Iterating through left and right parts of image (multiple images) and stitching them all
leftImagesNames <- list.files(path=leftImagesPath, pattern=".bmp", all.files=T, full.names=F, no.. = T)
rightImagesNames <- list.files(path=rightImagesPath, pattern=".bmp", all.files=T, full.names=F, no.. = T)

for(i in 1:length(leftImagesNames)) {
  stitchImages(leftImagesNames[i], rightImagesNames[i])
}



# # image validation
# stitchedImagesNames <- list.files(path=stitchedImagesPath, pattern=".bmp", all.files=T, full.names=F, no.. = T)
# sourceImagesNames <- list.files(path=sourceImagesPath, pattern=".bmp", all.files=T, full.names=F, no.. = T)
# 
# for(i in 1:length(stitchedImagesNames)){
#   stitchedImage <- read.bitmap(paste(stitchedImagesPath, stitchedImagesNames[i], sep=""))
#   sourceImage <- read.bitmap(paste(sourceImagesPath, sourceImagesNames[i], sep=""))
#   stitchedImage <- stitchedImage*255
# 
#   if(all(stitchedImage == sourceImage)) {
#     print(paste("[SUCCESS] Stitched image: ", stitchedImagesNames[i], " is identical to source image: ", sourceImagesNames[i], sep=""))
#   } else {
#     print(paste("[FAILED]  Stitched image: ", stitchedImagesNames[i], " is NOT identical to source image: ", sourceImagesNames[i], sep=""))
#   }
# }











