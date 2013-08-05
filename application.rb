#!/usr/bin/env ruby

require 'kramdown'
require 'Fileutils'
require_relative './src/generate_symbols'

SOURCE_FOLDER = 'mootools-core/Docs'
HTML_FOLDER = 'MooTools.docset/Contents/Resources/Documents/'


generate_from(SOURCE_FOLDER).each do |entry|
	puts '----------------'
	entry.each do |key, value|
		puts "#{key.to_s.rjust 15}: #{value}"
	end
end

puts '==============='

Dir.glob("#{SOURCE_FOLDER}/*/**/*.md").each do |filename|
	puts "Converting #{filename}..."

	html = Kramdown::Document.new(IO.read(filename)).to_html
	output = File.join(HTML_FOLDER, filename.sub(SOURCE_FOLDER, '').sub('.md', '.html'))

	FileUtils.mkdir_p(File.dirname(output))
	IO.write(output, html)
end
