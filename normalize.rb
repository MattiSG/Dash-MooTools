BLACKLISTED_FRAGMENTS = [
	'#Core',
	'#Deprecated-Functions'
]

OVERRIDDEN_TYPES = {
	'#Type' => 'Guide'
}

def normalize(entry)
	apply_overrides parse entry
end


def apply_overrides(data)
	return nil if is_blacklisted data

	fragment = data[:fragment]
	overridden_type = OVERRIDDEN_TYPES[fragment]

	data[:type] = overridden_type if overridden_type

	data
end

def is_blacklisted(data)
	BLACKLISTED_FRAGMENTS.include? data[:fragment]
end


def parse(entry)
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

	# TODO: values to treat specifically include:
	# - Type.Generics (not a method)
	# - Browser (object of objects)
	# - Deprecated
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