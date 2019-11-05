import vtk
import os
from glob import glob

mesh_path = "objects_meshes"
mesh_output_path = "objects_meshes_decimated"

vtk.vtkObject.GlobalWarningDisplayOff()
fn_indices = sorted([int(os.path.basename(fn).split("_")[1]) for fn in glob(os.path.join(mesh_path, "*"))])
try:
    os.mkdir(mesh_output_path)
except FileExistsError:
    pass
for i in fn_indices:
    in_file_name = "object_%d_with_norm.ply"%i
    out_file_name = "object_%d_decimated.ply"%i

    print("Processing %s..."%in_file_name)

    reader = vtk.vtkPLYReader()
    reader.SetFileName(os.path.join(mesh_path, in_file_name))
    reader.Update()
    poly_data = reader.GetOutput()

    decimate = vtk.vtkQuadricDecimation()
    decimate.AttributeErrorMetricOn()
    decimate.VolumePreservationOn()
    decimate.SetInputData(poly_data)
    decimate.SetTargetReduction(0.95)
    decimate.Update()

    plyWriter = vtk.vtkPLYWriter()
    plyWriter.SetFileName(os.path.join(mesh_output_path, out_file_name))
    plyWriter.SetInputConnection(decimate.GetOutputPort())
    plyWriter.Write()
