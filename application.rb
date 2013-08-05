#!/usr/bin/env ruby

require_relative './src/generate_symbols'

SOURCE_FOLDER = 'mootools-core/Docs'


generate_from(SOURCE_FOLDER).each do |entry|
	puts '----------------'
	entry.each do |key, value|
		puts "#{key.to_s.rjust 15}: #{value}"
	end
end
