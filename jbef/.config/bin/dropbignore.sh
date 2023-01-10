# =================================================================
# Custom script to have Dropbox ignore the files passed as arguments
# =================================================================
for f in "$@"
do
 xattr -w com.dropbox.ignored 1 "$f"
done
