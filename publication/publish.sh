INPUT="MooTools.docset"
OUTPUT="Dash-MooTools.tgz"

cd "`dirname $0`/.."
git submodule update
./application.rb
tar --exclude='.DS_Store' -czf $OUTPUT $INPUT

echo "Docset is ready for publication at $OUTPUT"
