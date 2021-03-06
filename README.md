# Image And Video Processing Algorithms #

## 1 - Image And Video Segmentation  ##
* <b>global_threshold_segmentation.m</b>: Segments an image when the background is relatively simple and its grayscale histogram is a bimodal distribution. 
* <b>local_dynamic_threshold_segmentation.m</b>: Divides the original image into several sub-images, and selects the corresponding segmentation threshold to complete the segmentation of the image. The function normalizes the non-uniform brightness intensity of the original image.
* <b>region_growing.m</b>: Combines the pixels with similar properties to form a region. Finds a seed pixel as the starting point for each growth area, then combines the pixels in the neighborhood with properties similar to the seed. The region grows if new pixels continue to meet the required conditions.


## 2 -  Feature Extraction And Representation ##
* <b>susan_corner_detection.m</b>: Calculates the corner features in an image using  a circular template.
* <b>sift.m</b>: Local descriptor used for object recognition and image matching. It has the invariance of scale, rotation and translation and is robust to illumination change, affine transformation and 3-D projection transformation.


## 3 - Image Inpainting ##
* <b>inpainting_CDD.m</b>: Implements Curvature-Driven Diffusions (CDD) inpainting model. In the CDD model, the total variation conductivity coefficient is modified so that the the curvature is as small as possible to obtain images more conform to human vision.
 
 ## 4 - Image Fusion ##
* <b>wavelet_fusion_regional_variance.m</b>: Performs wavelet fusion of regional variance. The original image is decomposed by discrete wavelet frames, and different rules of image fusion are used to fuse the low and high frequency images.
* <b>fuzzy_dempster_shafer.m</b>: Processes images using fuzzy Dempster-Shafer evidence theory. Fuzzy C-Means clustering is operated on two source images to get the fuzzy membership degree of each point in each image. The simple hypothesis and compound hypothesis are determined according to the fuzzy category. The single and compound basic probability assignment mass function values of  each pixel in the two images are determined by the heuristic least squares algorithm. The basic probability assignment of two images is fused with the Dempster criterion in D-S evidential theory. The final fusion result is obtained by decision.

 ## 5 - Image Stitching ##
 * <b>panoramic_stitching_ibr.m</b>: Does seamless stitching on an image sequence taken from the same scene with the same optical center and partial overlap, but with different perspective and different focal lengths. The image registration algorithm is used to calculate the motion parameters between each frame and then synthetize a large static wide-angle image.
 * <b>ratio_matching_stitching.m</b>: Performs image stitching based on ratio matching. It first selects the ratio of two columns of pixels with a certain distance between the overlapped parts of the template image. Then it searchs the best match for the overlapped region in the second image and finds two columns corresponding to the template taken from the first image to complete the image stitching. 

 ## 6 - Image Watermarking ##
 * <b>dct_watermarking.m</b>: Implements image watermarking based on the Discrete Cosine Transform (DCT). The original image is divided into 8×8 blocks. The variances of all the sub-blocks is first calculated, followed by the front n blocks with the maximum variance with maximum variance. The random sequence pn_sequence_zero is embedded in the medium frequency of the DCT domain according to the system key K. The result image is generated by the inverse DCT transform of the sub-blocks. K and pn_sequence_zero are used in combination to select the embedding position.
 * <b>dwt_watermarking.m</b>: Implements digital watermarking based on the Discrete Wavelet Transform (DWT). DWT uses a multi-resolution decomposition method to decompose the image, and adds the watermark in the corresponding sub-band coefficient image. The image of wavelet coefficients consists of several sub-bands of images of wavelet coefficients. The wavelet coefficients of different sub-bands reflect the characteristics of different spatial resolution of the image.

 ## 7 - Visual Object Recognition ##
 * <b>facial_expression_recognition.m</b>: Identifies facial expression in an image using Principal Component Analysis (PCA). Images used for the training and test sets are from in the YALE Face database. Ten images were selected for each kind of emotional expression. Images with three kinds of emotions (happiness, sadness, surprise) were selected as the training set, and each kind took 10 images. After training, images of known categories were tested, providing recognition of happiness, sadness, and surprise. After reducing the dimension of the face by the PCA method, the least nearest neighbor algorithm is used to identify an unknown facial emotion in an image.

## 8 - Visual Object Tracking ##
* <b>ransac_object_tracking.m</b>: Implements object tracking based on the random sampling consistency (RANSAC) algorithm. The input of the RANSAC algorithm is a set of observation data, a parametric model adapted to the observed data and some selected parameters to track the object by repeatedly selecting random subsets in the data.