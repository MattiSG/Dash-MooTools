require_relative '../resources/overrides'
require_relative '../resources/blacklist'


def parse(entry)
	fully_qualify_symbol apply_overrides parse_entry entry
end


def parse_entry(entry)
	# Example entry:
	# ./mootools-core/Docs/Types/String.md:String method: clean {#String:clean}
	# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^ ^^^^^^^  ^^^^^^ ^^^^^
	entry.match(/([^:]+):[^A-Za-z]*([A-Za-z. ]+ )?([^: ]+:)?[ ]*([^{]+){(#.+)}/) do
		#         ^$1^^             ^^^^^$2^^^^^   ^^^$3^^       ^$4^^   ^$5
		path = $1
		namespace = $2.strip if $2
		type = $3.chop if $3	# remove the separating colon
		symbol = $4.strip	#TODO: this can be removed by adding a space between $4 and $5 matchers in the regexp
		fragment = $5

		{
			source:		entry,	# helps with debugging
			namespace:	namespace,
			symbol:		symbol,
			type:		type,
			path:		path,
			fragment:	fragment
		}
	end
end

def apply_overrides(data)
	return nil if is_blacklisted data

	OVERRIDES.each do |property, overrides|
		overrides.each do |matcher, value|
			data[property] = value if data[:fragment].index matcher
		end
	end

	data
end


# Converts a namespace + symbol pair into a fully qualified symbol.
# Due to how entry data format, the distinction may be blurry. Fully qualifying before exporting makes sure we don't return inconsistent data (e.g. nil in one value, the FQN in another).
def fully_qualify_symbol(data)
	return nil if ! data	# overrides could have rejected the data

	namespace	= data.delete :namespace
	symbol		= data[:symbol]

	if namespace && symbol
		data[:symbol] = "#{namespace}.#{symbol}"	# notice the dot
	else	# at least one is nil, converted to the empty string
		data[:symbol] = "#{namespace}#{symbol}"
	end

	data
end

# @param	[Hash]		data	A parsed entry, as returned by #parse.
# @return	[Boolean]	True if the given data set should NOT be indexed.
def is_blacklisted(data)
	!! BLACKLIST.reduce(false) { |memo, matcher| memo || data[:fragment].index(matcher) }
end
