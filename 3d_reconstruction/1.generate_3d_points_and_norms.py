import numpy as np
import pickle
import cc3d
from scipy.linalg import norm
from sklearn.preprocessing import normalize
import os
from collections import defaultdict
from skimage.measure import regionprops

def main():
    print("Loading filtered cell-type map...")
    with open("filtered_celltype_maps.pkl", "rb") as f:
        filtered_celltype_maps = pickle.load(f)


    print("Finding surfaces...")
    padded_ctmaps = np.pad(filtered_celltype_maps, 1, 'constant', constant_values=-1)
    surface_ctmap = np.array(padded_ctmaps, copy=True)
    ct_coords = np.where(padded_ctmaps > -1)
    for x, y, z in zip(*ct_coords):
        ct = padded_ctmaps[x, y, z]
        if padded_ctmaps[x+1, y, z] == ct and padded_ctmaps[x-1, y, z] == ct and \
            padded_ctmaps[x, y+1, z] == ct and padded_ctmaps[x, y-1, z] == ct and \
            padded_ctmaps[x, y, z+1] == ct and padded_ctmaps[x, y, z-1] == ct:
            surface_ctmap[x, y, z] = -1

    print("Finding connected objects...")
    connectivity = 6 # only 26, 18, and 6 are allowed
    labels_out = cc3d.connected_components(filtered_celltype_maps + 1, connectivity=connectivity)
    labels_out_surface = np.pad(labels_out, 1, 'constant') * (surface_ctmap != -1)

    print("Extracting labels...")
    obj_ct_dic = {}
    xyz_dict = defaultdict(lambda: [])
    for x in range(labels_out_surface.shape[0]):
        for y in range(labels_out_surface.shape[1]):
            for z in range(labels_out_surface.shape[2]):
                obj_id = labels_out_surface[x, y, z]
                if obj_id > 0:
                    xyz_dict[obj_id].append([x, y, z])

    print("Calculating surface norms...")
    try:
        os.mkdir("objects")
    except FileExistsError:
        pass

    n_total_objects = np.max(labels_out_surface)
    for i in np.unique(labels_out_surface)[1:]:
        xyz = np.array(xyz_dict[i], dtype=float)
        if len(xyz) < 4:
            continue
        cell_type = padded_ctmaps[tuple(xyz[0].astype(int))]
        obj_ct_dic[i] = cell_type
        norm_vecs = np.zeros_like(xyz)
        for j in range(len(xyz)):
            xyz_p = np.delete(xyz, j, 0)
            xyz_diffs = xyz[j] - xyz_p
            forces = 1.0 / np.sum(xyz_diffs**2, axis=1)
            unit_vecs = xyz_diffs / norm(xyz_diffs, ord=2, axis=1).reshape([-1, 1])
            norm_vecs[j] = np.sum(unit_vecs * forces.reshape([-1, 1]), axis=0)
        with open("objects/object_%d_with_norm.xyz"%i, "w") as f:
            for (x, y, z), (nx, ny, nz) in zip(xyz, norm_vecs):
                f.write("%f\t%f\t%f\t%f\t%f\t%f\n"%(x, y, z, nx, ny, nz))
        if i % 100 == 0:
            print("Processed (%d/%d) objects..."%(i,n_total_objects))

    print("Saving cell type dictionary...")
    with open("obj_ct_dic.pkl", "wb") as f:
        pickle.dump(obj_ct_dic, f)

main()
