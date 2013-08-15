Dependencies
------------

To generate the HTML files from the Markdown sources, you'll need the [Kramdown](http://kramdown.rubyforge.org/) Markdown parser.

However, the current version of Kramdown [does not parse IDs with colons](https://github.com/gettalong/kramdown/pull/72). You'll therefore need to install a specific fork of it until [my PR](https://github.com/gettalong/kramdown/pull/74) is merged:

	git clone git@github.com:MattiSG/kramdown.git -b 'parse-header-id'
	cd kramdown
	ruby setup.rb config
	ruby setup.rb setup
	ruby setup.rb install
