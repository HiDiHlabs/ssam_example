SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
MERFISH_DIR="${SCRIPTPATH}/zenodo/MERFISH/raw_data"
OSMFISH_DIR="${SCRIPTPATH}/zenodo/osmFISH/raw_data"

download_file() {
  yn="y"
  if [ -f "$2" ]; then
    read -p "$2 exists. Do you want to download it again [y/n]? " yn
  fi
  case $yn in
    [Yy]*)
      curl -L --retry 5 "$1" -o "$2"
      ;;
    [Nn]*)
      ;;
    *)
      echo "Please answer y or n."
      ;;
  esac
}

echo "--- Script for downloading supplemental data (20220108) ---"
echo
echo "Downloading main supplemental data from Zenodo (10.5281/zenodo.3478502)..."
download_file "https://zenodo.org/record/3478502/files/supplemental_data_ssam_2019.zip?download=1" "${SCRIPTPATH}/zenodo.zip"
echo
echo "Decompressing the downloaded file...."
unzip zenodo.zip -d ${SCRIPTPATH}/zenodo
echo
echo "- Downloading MERFISH raw data from Data Dryad (10.5061/dryad.8t8s248)"
echo
echo "Downloading Moffitt_and_Bambah-Mukku_et_al_merfish_all_cells.csv..."
download_file "https://datadryad.org/stash/downloads/file_stream/68364" "${MERFISH_DIR}/Moffitt_and_Bambah-Mukku_et_al_merfish_all_cells.csv"
echo
echo "- Downloading MERFISH raw data from Science (10.1126/science.aau5324)"
echo
echo "Downloading aau5324_Moffitt_Table-S1.xlsx..."
download_file "https://science.sciencemag.org/content/sci/suppl/2018/10/31/science.aau5324.DC1/aau5324_Moffitt_Table-S1.xlsx" "${MERFISH_DIR}/aau5324_Moffitt_Table-S1.xlsx"
echo
echo "- Downloading scRNA-seq data for MERFISH from NCBI (GSE113576)"
echo
echo "Downloading GSE113576_barcodes.tsv.gz..."
download_file "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE113576&format=file&file=GSE113576%5Fbarcodes%2Etsv%2Egz" "${MERFISH_DIR}/GSE113576_barcodes.tsv.gz"
echo
echo "Downloading GSE113576_genes.tsv.gz..."
download_file "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE113576&format=file&file=GSE113576%5Fgenes%2Etsv%2Egz" "${MERFISH_DIR}/GSE113576_genes.tsv.gz"
echo
echo "Downloading GSE113576_matrix.mtx.gz..."
download_file "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE113576&format=file&file=GSE113576%5Fmatrix%2Emtx%2Egz" "${MERFISH_DIR}/GSE113576_matrix.mtx.gz"
echo
echo "- Downloading osmFISH raw data from linnarssonlab website (http://linnarssonlab.org/osmFISH/availability/)"
echo
echo "Downloading osmFISH_SScortex_mouse_all_cells.loom..."
download_file "http://linnarssonlab.org/osmFISH/osmFISH_SScortex_mouse_all_cells.loom" "${OSMFISH_DIR}/osmFISH_SScortex_mouse_all_cells.loom"
echo
echo "Downloading mRNA_coords_raw_counting.hdf5..."
download_file "https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/osmFISH/data/mRNA_coords_raw_counting.hdf5" "${OSMFISH_DIR}/mRNA_coords_raw_counting.hdf5"
echo
echo "Downloading polyT_seg.pkl..."
download_file "https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/osmFISH/data/polyT_seg.pkl" "${OSMFISH_DIR}/polyT_seg.pkl"
echo
echo "Done!"
