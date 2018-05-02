class OpenFileError < StandardError
	def message 
		"File does not exist"
	end
end