# Estimating color-concept associations from image statistics
In this study, we developed a new approach for estimating color-concept associations. Building on prior studies that used images downloaded from Google Images, we provide new insights into effectively estimating distributions of human color-concept associations across CIELAB color space. Specifically, we evaluated several methods for filtering the raw pixel content of the images in order to best predict color-concept associations obtained from human ratings. The most effective method extracted colors using a combination of cylindrical sectors in color space and color categories.  
![](Figures/pipeline.png)

We demonstrate that our approach can accurately predict average human color-concept associations for different fruits using only a small set of images.

This repo consists of the image dataset, jupyter notebooks, matlab scripts and data files required to predict the color-concept associations using the cylindrical sectors and color categories as features. This repo also contains additional notebooks for analysis.

## Dependencies
- [Python package](https://google-images-download.readthedocs.io/en/latest/index.html) for downloading Google images for a set of concepts. [(Link to Github Repo)](https://github.com/hardikvasa/google-images-download)    
``` $ pip install google_images_download ```
- [Jupyter notebook](https://jupyter.org/install) All Python code is written in Jupyter notebooks.  
- [Scikit-Image](https://scikit-image.org/download.html) for image processing in Python.  
``` $ conda install -c conda-forge scikit-image ```
- [MATLAB Engine API for Python](https://www.mathworks.com/help/matlab/matlab_external/install-the-matlab-engine-for-python.html)
- [Color Categorization](https://github.com/ArashAkbarinia/ColourCategorisation)
module for classifying each pixel as one of the focal color names.  

## Usability
The repo can be used and replicated in two different scenarios:
1. For prediction of color-concept associations of our fruit concepts using our trained fruit model described in the paper.
2. For prediction of color-concept associations of new concepts with new set of test images and colors using our trained fruit model.

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
  A csv file containing the color-concept association ratings from humans.
- ##### TestScripts
  Folder containing the input color data, human ratings and supporting MATLAB scripts of the test concepts of our study.
## Output
The output of this study is the predicted color-concept association ratings which can be further used to assign visually separable and semantic colors to different concepts. One of the sample predicted ratings can be seen in ErrCorrFrom3ModelsTOP50.ipynb

## Implementation

### To replicate the research study:
1. Download the entire repository or clone it to your own github.
2. Most data files are present as .csv and excel spreadsheets in the downloaded repo. To replicate the study, you need not run code to get these data files.
This step will involve running code if you wish to get features for new concepts. We extract features from the given set of images in this step.
##### Exp 1A, 1B and 1C (For top 50 images of concepts obtained from Google)
3. Detailed analysis of the number of features to be used for three models and what those features should be, from an array of features obtained from top 50 images, are in the jupyter notebooks AnalysisI (Ball), AnalysisII (Sector) and AnalysisIII( Sector + Category). This analysis includes which features are important to a specific model.
4. Using the specific features obtained from step 3, the predictions using Linear Regression are obtained in notebooks with title ErrCorrFrom3ModelsTOP50.ipynb. These notebooks use the four chosen features from the previously step 3. notebooks and determine how the predicted ratings differ from the actual ratings using squared error and correlation.  
  **Here, we also conclude that using 'Sector+Category' features best fit the prediction model. Table 1 in the paper describes the specific values used for selected features**  
  ##### Exp 2: Prediction models with different image types
5. To test the hypothesis that a model that accurately estimates humanlike color-concept association ratings will perform as well for natural images as it does for humanmade illustrations, we tested two new image sets for each fruit,
one of photographs and one of cartoons.




```[Link](url) and ![Image](src)```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

Once the model has been trained, it can be tested on new concepts \textit{and} new colors without the need to gather any new human ratings. The concept is queried in Google Images, the $k$ chosen features are extracted from the images for the desired colors, and the trained model weights are applied to the features to obtain the predictions.
