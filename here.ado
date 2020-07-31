program define here, rclass
	syntax [, nogit set]
	* FIXME: implement .git
	
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
		capture confirm file ".here"
		while (_rc) {
			* if at root folder without .here, stop with an error
			if ("`c(pwd)'" == "") {
				display in red "Project folder not found."
				quietly cd "``current''/"
				error 170
			}
			
			* if not, go up one level
			capture quietly cd ".."
			if (_rc) {
				display in red "Project folder not found."
				quietly cd "``current''/"
				error 170
			}
			capture confirm file ".here"
		}

		local `here' = c(pwd)	
		quietly cd "``current''/"
	}
	return local here "``here''/"
	global here "``here''/"
	display "``here''/"
end
