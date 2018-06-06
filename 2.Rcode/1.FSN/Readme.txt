All code used for obtaining the results of the simulation study can be found here. This was executed with Matlab 2015b and SPM12.

A general R file would be run, looping over every seed and average sample size. There are three versions, one for every thresholding method. The matlab code (more specifically the “se_computeALE.m” part, different versions can be found under se_computeALE_unc, se_computeALE_FWER and se_computeALE_clunc) was adapted, leaving out some parts near the end to minimise computation time. For uncorrected thresholding for instance it was not necessary to compute a cluster-level threshold. 

Within the R file the matlab code is invoked by executing “FSN.m”, which is a short file with path definition and two matlab files necessary for the ALE meta-analysis. All files used for the first analysis can be found under “Rcode" and “ALE_matlab”.

A second analysis needed to be executed because some meta-analyses failed. Rounding issues caused the largest obtained ALE value to be larger than the predefined maximum ALE value. This was solved by changing line 67 to “histEdges = double(0:round(10000*(maxPossibleAle+0.003)));” (+0.003 instead of +0.001). After this adaptation all meta-analyses could be computed. 
The code for the second analysis can be found in “ALE_adapted”. This only occurred when voxel- or cluster level FWE thresholding was applied, not when uncorrected thresholding was used, therefore “se_computeALE” was not adapted any further.
