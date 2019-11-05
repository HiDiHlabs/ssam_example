import os
from plyfile import PlyData, PlyElement
import numpy as np
import pickle
from glob import glob
from matplotlib.colors import to_rgba

with open("obj_ct_dic.pkl", "rb") as f:
    obj_ct_dic = pickle.load(f)
with open("denovo_celltype_colors.pkl", "rb") as f:
    colors = [np.round(np.array(to_rgba(c))*255).astype(int) for c in pickle.load(f)]
print(colors)

all_vertices = []
all_faces = []

mesh_path = "objects_meshes_decimated"
fn_indices = sorted([int(os.path.basename(fn).split("_")[1]) for fn in glob(os.path.join(mesh_path, "*"))])
cur_pos = 0
for n, idx in enumerate(fn_indices):
    in_file_name = "object_%d_decimated.ply"%idx
    print("Merging %s..."%in_file_name)
    plydata = PlyData.read(os.path.join(mesh_path, in_file_name))
    r, g, b, a = colors[obj_ct_dic[idx]]
    for x, y, z in plydata['vertex'].data:
        all_vertices.append((x, y, z, ))
    for face in plydata['face'].data:
        i, j, k = face[0] + cur_pos
        all_faces.append(([i, j, k], r, g, b))
    cur_pos += len(plydata['vertex'].data)

all_vertices = np.array(all_vertices, dtype=[('x', 'f4'), ('y', 'f4'), ('z', 'f4')])
all_faces = np.array(all_faces, dtype=[('vertex_indices', 'i4', (3,)), ('red', 'u1'), ('green', 'u1'), ('blue', 'u1')])

plydata = PlyData(
        [
            PlyElement.describe(
                all_vertices, 'vertex'
            ),
            PlyElement.describe(all_faces, 'face')
        ], text=False)

plydata.write('merged.ply')
