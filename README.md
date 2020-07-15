SSAM Example Jupyter Notebooks
==============================

This repository contains SSAM examples of three mouse brain tissue samples:
 - Primary somatosensory cortex (SSp) imaged by osmFISH
 - Hypothalamus preoptic region (POA) imaged by MERFISH
 - Primary visual cortex (VISp) imaged by multiplexed smFISH
 
And the diagnostic plots could be found in the following three directories: `diagplots_osmFISH`, `diagplots_MERFISH`, and `diagplots_multiplexed_smFISH`.

Note:
- To replicate the results in this repo, please use the package python-louvain == 0.13 (The newer version, python-louvain 0.14, uses a different randomization algorithm).

Supplemental Data
=================

The supplemental data used in the notebooks can be automatically downloaded using the script `download_data.sh`.

Citations
=========

J Park, W Choi, S Tiesmeyer, B Long, LE Borm, E Garren, TN Nguyen, S Codeluppi, M Schlesner, B Tasic, R Eils, N Ishaque. "Segmentation-free inference of cell types from in situ transcriptomics data." *bioRxiv* **800748**. doi: https://doi.org/10.1101/800748
