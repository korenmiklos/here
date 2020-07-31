program define here, rclass
	syntax [, nogit set]
	
	tempname here
	
	if ("`set'"=="set") {
		tempname myfile
		file open `myfile' using ".here", write replace
		
		local `here' = c(pwd)
	}
	else {
		tempname current
		local `current' = c(pwd)
		
		* are we there yet?
		are_we_there_yet, `git'
		while (_rc) {
			* if at root folder without .here, stop with an error
			if ("`c(pwd)'" == "") {
				break_with_error, directory(``current'')
			}
			
			* if not, go up one level
			capture quietly cd ".."
			if (_rc) {
				break_with_error, directory(``current'')
			}
			are_we_there_yet, `git'
		}

		local `here' = c(pwd)	
		quietly cd "``current''/"
	}
	return local here "``here''/"
	global here "``here''/"
	display "``here''/"
end

program define are_we_there_yet
	syntax [, nogit]
	
	capture confirm file ".here"
	if (_rc != 0) & ("`git'" != "nogit") {
		capture confirm file ".git"
	}
end

program define break_with_error
	syntax , directory(string)

	display in red "Project folder not found."
	quietly cd "`directory'/"
	error 170
end
