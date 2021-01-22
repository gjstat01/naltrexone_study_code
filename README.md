# naltrexone_study_code

Overview
2 GUIs which were made to facilitate the creation of heatmaps to display c-Fos counts and to quantify CGRP densities. Each GUI was created using GUIDE in MatLab v2017b. 
It should be noted that the c-Fos program was used to create heatmaps for neurons that had previously been identified. Neurons were marked using NIS-Elements Ar (Nikon Corporation, Minato City, Tokyo, Japan) using red or green markers. The program allows users to consolidate a directory of these images into locations of neurons normalized to the central canal and create heatmap distributions of neuron locations.

Installation
Download and place both the .m and .fig file in the desired working directory. This does not need to be the directory where images are located. In the same directory, you will need to also download the ‘export_fig’ toolbox created by Oliver J. Woodford and Yair M. Altman located here:  https://github.com/altmany/export_fig. This toolbox is not necessary for creating the heatmaps in MatLab, but was used to export the figures from the main axes into images.

Author
Gregory J.R. States

Contact
gregory.states@louisville.edu
