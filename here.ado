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
			* if not, go up one level
			quietly cd ".."
			capture confirm file ".here"
		}

		local `here' = c(pwd)	
		quietly cd "``current''"
	}
	return local here "``here''"
	global here "``here''"
	display "``here''"
end
