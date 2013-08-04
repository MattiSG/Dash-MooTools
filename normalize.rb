# Fragments listed here will be rejected, and the associated doc entry will not be indexed.
BLACKLIST = [
	'#Core',	# this namespace is not visible, stuff inside it is made available globally
	'#Deprecated-Functions',	# this is a warning block, it should not exist on its own
	'#Cookie-options',	# as a block of its own, it doesn't make sense: Cookie options should be available from the Cookie doc
	'#Window'	# Window does not exist on its own, it is simply a group of all global functions; doesn't seem to make sense to import. Open a PR if you disagree.
]

# First key depth is the value that is to be overridden after parsing.
# Second key depth is the fragment that triggers the override, either as a String or as RegExp.
# Value is the value to set.
#
# To understand the overrides, search for the fragment in the doc
OVERRIDES = {
	type: {
		'#Type' => 'Guide',
		'#Deprecated' => 'Object',
		'#Type:generics' => 'Guide',
		/#Fx-Transitions/ => 'Function',
		/:constructor$/ => 'Constructor',
		'#Number-Math' => 'Guide',
		/^#Slick$/ => 'Guide',
		/^#Slick:[^S]/ => 'Notation',	# selectors should be listed as notations; "Slick.definePseudo" is properly recognized as a function; what sets its fragment apart is it repeats Slick, as it is a static method (Slick:Slick-definePseudo)
		/#Browser:Browser-.*/ => 'Object'
	},
	symbol: {
		'#Type' => 'Types',
		'#Deprecated' => 'Browser.Engine',
		'#Type:generics' => 'Generics',
		/:constructor$/ => nil,
		'#Number-Math' => 'Math',
		/^#Slick$/ => 'Slick'
	},
	namespace: {
		'#Number-Math' => 'Number'
	}
}


def normalize(entry)
	fully_qualify_symbol apply_overrides parse entry
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


def apply_overrides(data)
	return nil if is_blacklisted data

	OVERRIDES.each do |property, overrides|
		overrides.each do |matcher, value|
			data[property] = value if data[:fragment].index matcher
		end
	end

	data
end

# @param	[Hash]		data	A parsed entry, as returned by #parse.
# @return	[Boolean]	True if the given data set should NOT be indexed.
def is_blacklisted(data)
	BLACKLIST.include? data[:fragment]
end


def parse(entry)
	entry.match(/([^:]+):[^A-Za-z]*([A-Za-z. ]+ )?([^: ]+:)?[ ]*([^{]+){(#.+)}/) do
		#         ^$1^^             ^^^^^$2^^^^^   ^^^$3^^       ^$4^^   ^$5
		path = $1
		namespace = $2.strip if $2
		type = $3.chop if $3	# remove the separating colon
		symbol = $4.strip	#TODO: this can be removed by adding a space between $4 and $5 matchers in the regexp
		fragment = $5

		{
			namespace:	namespace,
			symbol:		symbol,
			type:		type,
			path:		path,
			fragment:	fragment
		}
	end

	# TODO: should DOMEvent be aliased to Event, as in the official doc listing?
end