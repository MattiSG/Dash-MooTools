#!/usr/bin/env ruby


# Example entry:
# ./mootools-core/Docs/Types/String.md:String method: clean {#String:clean}
def normalize(entry)
	fragment = entry.split('{')[1].tr('#}', '')

	name = fragment.tr(':', '.')	# replace namespace marker with method-accessor syntax

	path = entry.split(':')[0]
	path << '#'
	path << fragment

	type = fragment.include?(':') ? 'Method' : 'Class'	# a class is not namespaced

	puts "name: #{name}"
	puts "path: #{path}"
	puts "type: #{type}"

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

`grep '{#' --recursive mootools-core/Docs`.each_line do |entry|	# MooTools docs are nicely annotated with their unique anchor reference
	normalize entry
	puts
end
