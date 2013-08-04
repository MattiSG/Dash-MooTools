BLACKLISTED_FRAGMENTS = [
	'#Core',
	'#Deprecated-Functions'
]

OVERRIDDEN_TYPES = {
	'#Type' => 'Guide',
	'#Deprecated' => 'Object',
	'#Type:generics' => 'Guide',
	/#Fx-Transitions/ => 'Function'
}

OVERRIDDEN_SYMBOLS = {
	'#Type' => 'Types',
	'#Deprecated' => 'Browser.Engine',
	'#Type:generics' => 'Generics'
}

def normalize(entry)
	apply_overrides parse entry
end


def apply_overrides(data)
	return nil if is_blacklisted data

	fragment = data[:fragment]

	OVERRIDDEN_TYPES.each do |matcher, type|
		data[:type] = type if fragment.index matcher
	end

	OVERRIDDEN_SYMBOLS.each do |matcher, symbol|
		data[:symbol] = symbol if fragment.index matcher
	end

	data
end

def is_blacklisted(data)
	BLACKLISTED_FRAGMENTS.include? data[:fragment]
end


def parse(entry)
	entry.match(/([^:]+):[^A-Za-z]*([A-Za-z. ]+\ )?([^:]+)[:\ ]*([^{]*){(#.+)}/) do
		#         ^$1^^             ^^^^^$2^^^^^^   ^$3^^        ^$4^^   ^$5
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
	# - Browser.* (types)
	# - Cookie-options
	# - Number-Math
	# - Element-Properties
	# - Element-NativeEvents
	# - Element-Events
	# - Request.send-aliases
	# - Slick stuff are no methods, they are “selectors”
	# - constructors (should be of type constructor, and the method name should probably not be "constructor")
	# - Window (should not be namespaced in "window" as offered as global)
	# - dollar / dollars -> $ / $$

	# TODO: should DOMEvent be aliased to Event, as in the official doc listing?
end