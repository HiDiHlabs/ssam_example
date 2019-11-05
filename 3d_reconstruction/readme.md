MERFISH 3D cell-type map reconstruction
=======================================

This script is to generate 3D cell-type map of the MERFISH data. This script was currently only tested on Linux.

Usage
-----

0. Compile `PoissonRecon`. Copy the compiled binary to this directory.

```bash
$ cd PoissonRecon
$ make
```

1. Run `MERFISH_POA.ipynb`. Save the 3D cell-type map and the cell-type colors to pickles.

```python
with open("filtered_celltype_maps.pkl", "wb") as f:
    pickle.dump(ds.filtered_celltype_maps, f)
with open("denovo_celltype_colors.pkl", "wb") as f:
    pickle.dump(denovo_celltype_colors, f)
```

2. Run all scripts. Open `merged.ply` with MeshLab:

![MeshLab screenshot](images/meshlab.jpg?raw=true)
