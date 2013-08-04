#!/usr/bin/env ruby

require "./normalize.rb"
require "./additions.rb"

SOURCE_FOLDER = 'mootools-core/Docs'

# Example entry:
# ./mootools-core/Docs/Types/String.md:String method: clean {#String:clean}
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^ ^^^^^^^  ^^^^^^ ^^^^^

`grep '{#' --recursive #{SOURCE_FOLDER}`.each_line do |entry|	# MooTools docs are nicely annotated with their unique anchor reference
	data = normalize entry

	next if data.nil?

	puts '----------------'
	puts "data: #{entry}"
	data.each do |key, value|
		puts "#{key.to_s.rjust 15}: #{value}"
	end
end

ADDITIONS.each do |entry|
	data = fully_qualify_symbol apply_overrides entry

	puts '----------------'
	puts "data: ADDITIONS"
	data.each do |key, value|
		puts "#{key.to_s.rjust 15}: #{value}"
	end
end
