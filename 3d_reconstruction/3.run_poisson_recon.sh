mkdir -p objects_meshes
for fn in `ls objects_cleaned`
do
  ./PoissonRecon --in objects_cleaned/$fn --out objects_meshes/${fn%.xyz} --verbose
done
