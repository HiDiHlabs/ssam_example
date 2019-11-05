MIN_POINTS=100

mkdir -p objects_cleaned
for fn in `ls objects`; do
  linenum=`wc -l < objects/$fn`
  if [ "$linenum" -gt "$MIN_POINTS" ]; then
    ln -sf "../objects/$fn" "objects_cleaned/$fn"
  fi
done
