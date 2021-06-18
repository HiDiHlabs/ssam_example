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

Jeongbin Park, Wonyl Choi, Sebastian Tiesmeyer, Brian Long, Lars E. Borm, Emma Garren, Thuc Nghi Nguyen, Bosiljka Tasic, Simone Codeluppi, Tobias Graf, Matthias Schlesner, Oliver Stegle, Roland Eils & Naveed Ishaque. "[Cell segmentation-free inference of cell types from in situ transcriptomics data.](https://www.nature.com/articles/s41467-021-23807-4)" *Nature Communications* **12**, 3545 (2021).
