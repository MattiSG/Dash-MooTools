#!/usr/bin/env ruby

# This file outputs all parsed symbols, helping with debugging and creating test cases.

require_relative '../src/generate_symbols'

SOURCE_FOLDER = 'mootools-core/Docs'

generate_from(SOURCE_FOLDER).each do |entry|
	puts '---------------'
	entry.each do |key, value|
		puts "#{key.to_s.rjust 15}: #{value}"
	end
end
