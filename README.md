# JCNF (Joint Convolutional Neural Fields) Model

> Version 1.0 (19 Feb. 2019)
>
> Contributed by Seungryong Kim (srkim89@yonsei.ac.kr).

This code is written in MATLAB, and implements the JCNF descriptor [[website](https://github.com/seungryong/JCNF/)]. 

## Dependencies ##
  - Download [[VLFeat](http://www.vlfeat.org/)] and [[MatConvNet](http://www.vlfeat.org/matconvnet/)].
  - Download the datasets:
    - [[MPI-SINTEL Benchmark](http://sintel.is.tue.mpg.de/)] 
([external link(https://drive.google.com/open?id=1K_8wnyc2fvxT9tlzCUaRapz0zm6k0sjL)]);

## Getting started ##
  - `Global_Depth_Network`: scripts for learning global depth network
  - `Depth_Intrinsic_Gradient_Network`: scripts for learning depth/intrinsic gradient network
  - `Gradient_Scale_Network`: scripts for learning depth/intrinsic-scale network
  - `Inference`: scripts for inference 
    
## Pre-trained Models ##
  - Global Depth Model: [[depth-net.mat](https://drive.google.com/open?id=1Ff1SrVL1kCZQaLVVmltTIK_8bcPQ9yFR)].
  - Depth Intrinsic Gradient Model: [[depth-intrinsic-gradient.mat](https://drive.google.com/open?id=1gDVFIUls_wfM81JlbLC6UyB9c-1G_1xm)].
  - Gradient Scale Models: [[depth-gradient-scale.mat](https://drive.google.com/open?id=1ZFhXtZgOuplpHv3LF3DSAGJMQ0D9RY2v)], [[albedo-gradient-scale.mat](https://drive.google.com/open?id=1nPVvBsH7PtAragc8c-WJUvu3g2s74ae8)], [[shading-gradient-scale.mat](https://drive.google.com/open?id=1H8dy9dKJ_SwhoKkQk_dmwPm60lXchtsJ)].

## Inference ##
  - `Inference/main.m`: predicts depth, albedo, and shading simultaneously
  
## Notes ##

  - The code is provided for academic use only. Use of the code in any commercial or industrial related activities is prohibited. 
  - If you use our code, please cite the paper. 

```
@InProceedings{kim2016,
author = {Seungryong Kim and Kihong Park and Kwanghoon Sohn and Stephen Lin},
title = {Unified Depth Prediction and Intrinsic Image Decomposition from a Single Image via Joint Convolutional Neural Fields},
booktitle = {European Conference on Computer Vision (ECCV)},
year = {2016}
}
```
