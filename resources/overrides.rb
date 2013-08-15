# This file defines hardcoded override values for some elements where the parser can't extract the proper data to use.
#
# First key depth is the value that is to be overridden after parsing.
# Second key depth is the fragment that triggers the override, either as a String or a RegExp.
# Value is the value to set.
#
# To understand the overrides, search for the fragment in the doc.
OVERRIDES = {
	type: {
		'#Type'					=> 'Guide',
		'#Deprecated'			=> 'Object',
		'#Type:generics'		=> 'Guide',
		/#Fx-Transitions/		=> 'Function',
		/:constructor$/			=> 'Constructor',
		'#Number-Math'			=> 'Guide',
		/^#Slick$/				=> 'Guide',
		/^#Slick:[^S]/			=> 'Notation',	# selectors should be listed as notations; "Slick.definePseudo" is properly recognized as a function; what sets its fragment apart is it repeats Slick, as it is a static method (Slick:Slick-definePseudo)
		/#Browser:Browser-.*/	=> 'Object'
	},
	symbol: {
		'#Type'					=> 'Types',
		'#Deprecated'			=> 'Browser.Engine',
		'#Type:generics'		=> 'Generics',
		/:constructor$/			=> nil,
		'#Number-Math'			=> 'Math',
		/^#Slick$/				=> 'Slick'
	},
	namespace: {
		'#Number-Math'			=> 'Number'
	}
}
