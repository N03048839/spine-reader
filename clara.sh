

PROJECT_DIR="C:/Users/Jobin/My Documents/programs/spine-reader"

# --- Stores location of input (bookshelf) image directory --
IMG_DIR=$PROJECT_DIR\images
echo "Image dir: $IMG_DIR"

# --- Stores location of call number image directory ---
LABEL_DIR=$PROJECT_DIR\lasttest\images
echo "File dir: $LABEL_DIR"

# --- Stores location of ocr output directory ---
OUT_DIR=$PROJECT_DIR\lasttest\outputs
echo "Output dir: $OUT_DIR"


cd $PROJECT_DIR


# --- Process input images and extract call number regions
inputImages=$(ls -1 $IMG_DIR | grep ".jpg")
for image in $inputImages
do
	echo "Scanning image $image"
	python process.py --out $LABEL_DIR images/$image
done
read  -n 1 -p "Press any key to continue..." pause1

# --- perform OCR on each processed label
labels=$(ls -1 $LABEL_DIR | grep ".png")
for label in $labels
do
	echo " === Analyzing image $label..."
	tesseract $LABEL_DIR/$label $OUT_DIR/$label
	echo "Output saved to $label.txt"
	
	cat $OUT_DIR/$label.txt
done

read  -n 1 -p "done" pause2
