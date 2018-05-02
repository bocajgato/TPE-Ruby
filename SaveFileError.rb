class SaveFileError < StandardError
	def message 
		"Could not creat the file"
	end
end