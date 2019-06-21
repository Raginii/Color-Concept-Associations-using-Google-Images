# Estimating color-concept associations from image statistics
In this study, we developed a new approach for estimating color-concept associations. Building on prior studies that used images downloaded from Google Images, we provide new insights into effectively estimating distributions of human color-concept associations across CIELAB color space. Specifically, we evaluated several methods for filtering the raw pixel content of the images in order to best predict color-concept associations obtained from human ratings. The most effective method extracted colors using a combination of cylindrical sectors in color space and color categories.  
![](Figures/pipeline.png)

We demonstrate that our approach can accurately predict average human color-concept associations for different fruits using only a small set of images.

This repo consists of the image dataset, data files, jupyter notebooks, matlab scripts and data files required to predict the color-concept associations using the cylindrical sectors and color categories as features. This repo also contains additional notebooks for analysis.

## Dependencies
- [Python package](https://google-images-download.readthedocs.io/en/latest/index.html) for downloading Google images for a set of concepts. [(Link to Github Repo)](https://github.com/hardikvasa/google-images-download)    
``` $ pip install google_images_download ```
- [Jupyter notebook](https://jupyter.org/install) All Python code is written in Jupyter notebooks.  
- [Scikit-Image](https://scikit-image.org/download.html) for image processing in Python.  
``` $ conda install -c conda-forge scikit-image ```
- [MATLAB Engine API for Python](https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html)
- [Color Categorization](https://github.com/ArashAkbarinia/ColourCategorisation)
module for classifying each pixel as one of the focal color names.  

The repo can be used and replicated in two different scenarios:
1. For prediction of color-concept associations of new concepts using the trained fruit model.
2. For training and prediction of color-concept associations of new concepts using new set of training images and new colors.

## Input Files and Directories
- ##### Downloads
  Folder containing the image dataset with specific type of image like 'top', 'cartoon' and 'photo'. Inside these folders should be the folders containing the specific concept images.
- ##### LAB.csv
  A csv file of color coordinates in LAB space.
- ##### RGB.csv
  A csv file of color coordinates in RGB space.
- ##### Category.csv
  A csv file of the color category of chosen colors.
- ##### data_clean.csv
  A csv file of color coordinates in LAB space.
- ##### TestScripts
  Folder containing the input color data, human ratings and supporting MATLAB scripts of the test concepts of our study.





```[Link](url) and ![Image](src)```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).
