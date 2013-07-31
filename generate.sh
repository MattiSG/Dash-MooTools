source 'MSGShellUtils/paths.sh'

SOURCE_FOLDER="$(dirname $0)/mootools-core/Docs"

name=''
type=''
path=''


# Example entry:
# ./mootools-core/Docs/Types/String.md:String method: clean {#String:clean}
function normalizeEntry {
	local entry="$*"
	local fragment=$(echo $entry | cut -d '{' -f 2 | tr -d '#}')

	name="$(echo $fragment | tr ':' '.')"
	type='TODO'
	path="$(echo $entry | cut -d ':' -f 1)#$fragment"
}


disableSpaceAsSeparator	# ensure loop beneath is over lines, not words

for entry in $(grep '{#' --recursive $SOURCE_FOLDER)	# MooTools docs are nicely annotated with their unique anchor reference
do
	normalizeEntry $entry
	echo "name: $name"
	echo "type: $type"
	echo "path: $path"
	echo
done

restoreSeparators
