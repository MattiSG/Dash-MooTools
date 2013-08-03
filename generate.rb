#!/usr/bin/env ruby

require "./normalize.rb"

SOURCE_FOLDER = 'mootools-core/Docs'

# Example entry:
# ./mootools-core/Docs/Types/String.md:String method: clean {#String:clean}
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ ^^^^^^^^^^^^^ ^^^^^^^  ^^^^^^ ^^^^^

`grep '{#' --recursive #{SOURCE_FOLDER}`.each_line do |entry|	# MooTools docs are nicely annotated with their unique anchor reference
	data = normalize entry
	puts '----------------'
	puts entry
	data.each do |key, value|
		puts "#{key.to_s.rjust 15}: #{value}"
	end
end
