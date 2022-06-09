# =================================================================
# Custom script to have Dropbox unignore the files passed as arguments
# =================================================================
for f in "$@"
do
 xattr -d com.dropbox.ignored "$f"
done
