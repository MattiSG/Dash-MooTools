require_relative './parse'
require_relative '../resources/additional_symbols'

def generate_from(folder)
	result = parse_data_from folder
	result.concat generate_additional_symbols
end


def parse_data_from(folder)
	result = []
	# MooTools docs are nicely annotated with their unique anchor reference, so we use this to extract lines
	`grep '{#' --recursive #{SOURCE_FOLDER}`.each_line { |entry| result << parse(entry) }
	result.compact	# entries may be rejected, which consists in being nil; we therefore remove such entries
end

def generate_additional_symbols
	ADDITIONS.map { |entry| fully_qualify_symbol apply_overrides entry }
end
