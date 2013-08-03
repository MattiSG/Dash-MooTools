def normalize(entry)
	# entry.match(/([A-Za-z/-]+)\.md:([A-Za-z]\ )?([A-Za-z]+):[^{]{#[^:]+}/)
	entry.match(/([^:]+):[^A-Za-z]*([A-Za-z ]+\ )?([^:]+)[:\ ]*([^{]*){(#.+)}/) do
		#         ^$1^^             ^^^^^$2^^^^^   ^$3^^        ^$4^^   ^$5
		path = $1
		namespace = $2.strip if $2
		type = $3
		symbol = $4.strip
		fragment = $5

		{
			namespace:	namespace,
			symbol:		symbol,
			type:		type,
			path:		path,
			fragment:	fragment
		}
	end

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
end