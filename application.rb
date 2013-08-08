#!/usr/bin/env ruby

require 'kramdown'
require 'Fileutils'
require_relative './src/generate_symbols'

SOURCE_FOLDER = 'mootools-core/Docs'
DOCSET_RESOURCES = 'MooTools.docset/Contents/Resources'
HTML_FOLDER = "#{DOCSET_RESOURCES}/Documents/"
INDEX_FILE = "#{DOCSET_RESOURCES}/docSet.dsidx"
INIT_FILE = 'init.sql'


Dir.glob("#{SOURCE_FOLDER}/*/**/*.md").each do |filename|
	print "Converting #{filename}... "

	html = Kramdown::Document.new(IO.read(filename)).to_html
	output = File.join(HTML_FOLDER, filename.sub(SOURCE_FOLDER, '').sub('.md', '.html'))

	FileUtils.mkdir_p(File.dirname(output))
	IO.write(output, html)
	puts 'done'
end

puts '==============='

print 'Indexing'

sql = []
sql << 'CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);'
sql << 'CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);'

generate_from(SOURCE_FOLDER).each do |entry|
	print '.'
	entry.each do |key, value|
		target = entry[:path].sub("#{SOURCE_FOLDER}/", '').sub('.md', '.html')
		target << entry[:fragment]
		symbol = entry[:symbol].gsub("'", '')	# remove single quotes to ensure SQL is properly formatted; the only time where quotes are in a symbol are with Slick selectors: Last Child ('!^')
		sql << "INSERT OR IGNORE INTO searchIndex(name, type, path) VALUES ('#{symbol}', '#{entry[:type]}', '#{target}');"
	end
end

sql << ''
IO.write(INIT_FILE, sql.join("\n"))

puts ' done'

print 'Generating database... '
`cat #{INIT_FILE} | sqlite3 #{INDEX_FILE}`	# if we use the -init option of sqlite3, it is started as interactive and will never finish
puts 'done'


puts 'Docset is ready!'
