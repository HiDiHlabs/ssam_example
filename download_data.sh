SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
MERFISH_DIR="${SCRIPTPATH}/zenodo/MERFISH/raw_data"
OSMFISH_DIR="${SCRIPTPATH}/zenodo/osmFISH/raw_data"
echo "--- Script for downloading supplemental data (20191016) ---"
echo
echo "Downloading main supplemental data from Zenodo..."
curl "https://zenodo.org/record/3478502/files/supplemental_data_ssam_2019.zip?download=1" -o ${SCRIPTPATH}/zenodo.zip
echo
echo "Decompressing the downloaded file...."
unzip zenodo.zip -d ${SCRIPTPATH}/zenodo
echo
echo "- Downloading MERFISH raw data from Data Dryad (10.5061/dryad.8t8s248)"
echo
echo "Downloading Moffitt_and_Bambah-Mukku_et_al_merfish_all_cells.csv..."
curl "https://datadryad.org/stash/downloads/file_stream/68364" -o "${MERFISH_DIR}/Moffitt_and_Bambah-Mukku_et_al_merfish_all_cells.csv"
echo
echo "- Downloading MERFISH raw data from Science (10.1126/science.aau5324)"
echo
echo "Downloading aau5324_Moffitt_Table-S1.xlsx..."
curl "https://science.sciencemag.org/content/sci/suppl/2018/10/31/science.aau5324.DC1/aau5324_Moffitt_Table-S1.xlsx" -o "${MERFISH_DIR}/aau5324_Moffitt_Table-S1.xlsx"
echo
echo "- Downloading scRNA-seq data for MERFISH from NCBI (GSE113576)"
echo
echo "Downloading GSE113576_barcodes.tsv.gz..."
curl "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE113576&format=file&file=GSE113576%5Fbarcodes%2Etsv%2Egz" -o "${MERFISH_DIR}/GSE113576_barcodes.tsv.gz"
echo
echo "Downloading GSE113576_genes.tsv.gz..."
curl "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE113576&format=file&file=GSE113576%5Fgenes%2Etsv%2Egz" -o "${MERFISH_DIR}/GSE113576_genes.tsv.gz"
echo
echo "Downloading GSE113576_matrix.mtx.gz..."
curl "https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE113576&format=file&file=GSE113576%5Fmatrix%2Emtx%2Egz" -o "${MERFISH_DIR}/GSE113576_matrix.mtx.gz"
echo
echo "- Downloading osmFISH raw data from linnarssonlab website (http://linnarssonlab.org/osmFISH/availability/)"
echo
echo "Downloading osmFISH_SScortex_mouse_all_cells.loom..."
curl http://linnarssonlab.org/osmFISH/osmFISH_SScortex_mouse_all_cells.loom -o "${OSMFISH_DIR}/osmFISH_SScortex_mouse_all_cells.loom"
echo
echo "Downloading mRNA_coords_raw_counting.hdf5..."
curl https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/osmFISH/data/mRNA_coords_raw_counting.hdf5 -o "${OSMFISH_DIR}/mRNA_coords_raw_counting.hdf5"
echo
echo "Downloading polyT_seg.pkl..."
curl https://storage.googleapis.com/linnarsson-lab-www-blobs/blobs/osmFISH/data/polyT_seg.pkl -o "${OSMFISH_DIR}/polyT_seg.pkl"
echo
echo "Done!"
