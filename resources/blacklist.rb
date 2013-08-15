# Fragments listed here (either as a String or a RegExp) will be rejected, and the associated doc entry will not be indexed
BLACKLIST = [
	'#Core',	# this namespace is not visible, stuff inside it is made available globally
	/#Deprecated-Functions/,	# these are deprecated and not available in 1.4 anymore
	'#Cookie-options',	# as a block of its own, it doesn't make sense: Cookie options should be available from the Cookie doc
	'#Window'	# Window does not exist on its own, it is simply a group of all global functions; doesn't seem to make sense to import. Open a PR if you disagree.
]
