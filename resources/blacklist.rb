# Fragments listed here will be rejected, and the associated doc entry will not be indexed.
BLACKLIST = [
	'#Core',	# this namespace is not visible, stuff inside it is made available globally
	'#Deprecated-Functions',	# this is a warning block, it should not exist on its own
	'#Cookie-options',	# as a block of its own, it doesn't make sense: Cookie options should be available from the Cookie doc
	'#Window'	# Window does not exist on its own, it is simply a group of all global functions; doesn't seem to make sense to import. Open a PR if you disagree.
]
