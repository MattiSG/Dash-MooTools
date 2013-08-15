Installing the [MooTools](http://mootools.net) docset in [Dash](http://kapeli.com/dash)
=======================================================================================

![Installation instructions](https://raw.github.com/MattiSG/Dash-MooTools/master/publication/instructions.png)

1. Open [Dash](http://kapeli.com/dash).
2. Open up the Preferences.
3. Go to the Downloads pane.
4. Click on the `+` button (lower left).
5. Paste: `http://mattischneider.fr/feeds/MooTools.xml`.
6. Click “Download”.
7. Ta-daaa!

If you find this piece of software valuable, starring this repo is a great way to show appreciation  :)


Hacking the parser / generator
==============================


Architecture
------------

If you want to improve the doc parser, here's the project architecture:

- `application.rb` generates the docset.
- `publication/publish.sh` generates an archive ready for publication; remember to update the `publication/mootools.xml` version number to trigger an update!
- The `src` folder contains all parser parts.
- The `resources` folder contains manual exclusions and additions that influence the automatic parser. That's the place to go if you need to override something that was automatically parsed.
- The `spec` folder contains tests for the parser. Simply run `rspec` in the root folder to run tests.


### Source

The docs are taken from the `mootools-core` submodule, so make sure you `git submodule update --init` when you clone the project!


### Updating the parser

If you want to update the parser, start by adding the testcase for the data you want parsed in the `parse_spec` file.
For that, the easiest way is to run `spec/output_all.rb`, locate the source of the entry you want edited, copy-and-paste its contents to the spec file, and transform it into a test case based on all the examples you have there.

Then, have your test fail by running `rspec`.

Then, improve the parser in `src/parse.rb`, or simply add an override in `resources/overrides.rb` or an exclusion in `resources/blacklist.rb`.


### Improving the view

If you want to improve the rendering of the documentation pages, you can edit:

- `resources/template.html.erb` to change the HTML structure in which the parsed doc gets inserted after having been translated from Markdown.
- `MooTools.docset/Contents/Resources/Stylesheets/*.css` to change the CSS. Remember that the source of those files is the [official doc](http://mootools.net/docs) itself, and it is probably better to keep the same look.


Dependencies
------------

### Runtime

This project is written in Ruby.


### Generation

To generate the HTML files from the Markdown sources, you'll need the [Kramdown](http://kramdown.rubyforge.org/) Markdown parser.

However, the current version of Kramdown [does not parse IDs with colons](https://github.com/gettalong/kramdown/pull/72). You'll therefore need to install a specific fork of it until [my PR](https://github.com/gettalong/kramdown/pull/74) is merged:

	git clone git@github.com:MattiSG/kramdown.git -b 'parse-header-id'
	cd kramdown
	ruby setup.rb config
	ruby setup.rb setup
	ruby setup.rb install


### Tests

You'll need `rspec`: `gem install rspec` if you don't already have it.
