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

	name="$(echo $fragment | tr ':' '.')"	# replace namespace marker with method-accessor syntax

	path="$(echo $entry | cut -d ':' -f 1)#$fragment"

	if echo $fragment | grep -q ':'	# a class is not namespaced
	then type='Method'
	else type='Class'
	fi

	# TODO: handle static methods
	# They are spottable as the method name repeats the class name. Ex: String.String-from

	# TODO: values to treat specifically include:
	# - Core (present as global)
	# - Type.Generics (not a method)
	# - Browser (object of objects)
	# - Deprecated
	# - Deprecated-Functions (remove? if not, prefix with `$` as when exposed)
	# - Cookie-options
	# - Number-Math
	# - Element-Properties
	# - Element-NativeEvents
	# - Element-Events
	# - Request.send-aliases
	# - Request-JSON
	# - Request-HTML
	# - Fx-Transitions (hyphenated name + type (object))
	# - Slick stuff are no methods, they are “selectors”
	# - constructors (should be of type constructor, and the method name should probably not be "constructor")
	# - Window (should not be namespaced in "window" as offered as global)
	# - dollar / dollars -> $ / $$

	# TODO: should DOMEvent be aliased to Event, as in the official doc listing?
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
