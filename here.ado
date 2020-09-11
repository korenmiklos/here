program define here, rclass
	syntax [, nogit set]
	
	tempname here
	
	if ("`set'"=="set") {
		tempname myfile
		file open `myfile' using ".here", write replace
		
		local `here' = c(pwd)
	}
	else {
		tempname current previous
		local `current' = c(pwd)
		
		* are we there yet?
		are_we_there_yet, `git'
		while (_rc) {
			* if not, go up one level

			local `previous' = c(pwd)
			capture quietly cd ".."

			* if at root folder, cd .. might fail or keep pwd the same
			* in either case, we have not found .here so stop with an error
			if (_rc) | ("`c(pwd)'" == "``previous''") {
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
		capture confirm file ".git/config"
	}
end

program define break_with_error
	syntax , directory(string)

	display in red "Project folder not found."
	quietly cd "`directory'/"
	error 170
end
