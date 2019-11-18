#!/bin/bash
#
# ENSICAEN
# 6 Boulevard Maréchal Juin 
# F-14050 Caen Cedex 
#
# Author: Jules Klein <klein@ecole.ensicaen.fr>
# Version 1.0 2019/09/23
#
#
# This script sets the correct comments (and #ifndef stuff if .h)
# at the start of a file, depending on the extension
# It accepts .sh, .c, .h, .py 
#
#
# use : sethc.sh file
#
# TODO :
# add other languages if needed
# replace the if/elif/else with case if possible
# rewrite for compatibility with sh if possible


# this function tests if the file is empty and if not asks to erase it
test_empty () {
    if [ -s "$1" ]
    then
       while :
       do
	   echo "the file is not empty. Do you want to erase it (y/n) ?"
	   read -r choice
	   case "$choice" in
	       "y"|"Y") cat /dev/null > ${file}
			echo "$1 was successfully erased"
			break
			;;
	       "n"|"N") echo "Aborting !"
			exit 0
			;;
	       *) echo "Invalid answer"
		  ;;
	   esac
       done
    fi
}

# This function formats shell script files
add_hc_shell () {
    file=$1
    echo "#!/bin/sh" >> "${file}"
    echo "#" >> "${file}"
    echo "#" >> "${file}"
    echo "# ENSICAEN" >> "${file}"
    echo "# 6 Boulevard Maréchal Juin" >> "${file}" 
    echo "# F-14050 Caen Cedex" >> "${file}"
    echo "#" >> "${file}"
    echo "# This file is owned by ENSICAEN." >> "${file}"
    echo "# No portion of this document may be reproduced, copied" >> "${file}"
    echo "# or revised without written permission of the authors." >> "${file}"
    echo "#" >> "${file}"
    echo "# Author: Jules Klein <klein@ecole.ensicaen.fr>" >> "${file}"
    echo "# Version 1.0 $(date +%d/%m/%Y)" >> "${file}"
    echo "#" >> "${file}"
    echo "#" >> "${file}"
    echo "# [Function of script]" >> "${file}"
    echo "#" >> "${file}"
    echo "#" >> "${file}"
    echo "# [Correct use of script]" >> "${file}"
}

# This function formats python script files
add_hc_python () {
    file=$1
    echo "#!/bin/python3" >> "${file}"
    echo "#" >> "${file}"
    echo "#" >> "${file}"
    echo "# ENSICAEN" >> "${file}"
    echo "# 6 Boulevard Maréchal Juin" >> "${file}" 
    echo "# F-14050 Caen Cedex" >> "${file}"
    echo "#" >> "${file}"
    echo "# This file is owned by ENSICAEN." >> "${file}"
    echo "# No portion of this document may be reproduced, copied" >> "${file}"
    echo "# or revised without written permission of the authors." >> "${file}"
    echo "#" >> "${file}"
    echo "# Author: Jules Klein <klein@ecole.ensicaen.fr>" >> "${file}"
    echo "# Version 1.0 $(date +%d/%m/%Y)" >> "${file}"
    echo "#" >> "${file}"
    echo "#" >> "${file}"
    echo "# [Function of script]" >> "${file}"
    echo "#" >> "${file}"
    echo "#" >> "${file}"
    echo "# [Correct use of script]" >> "${file}"
}

# This function formats C source files
add_hc_c () {
    file=$1
    echo " /* ENSICAEN" >> "${file}"
    echo " * 6 Boulevard Maréchal Juin" >> "${file}" 
    echo " * F-14050 Caen Cedex" >> "${file}"
    echo " *" >> "${file}"
    echo " * This file is owned by ENSICAEN." >> "${file}"
    echo " * No portion of this document may be reproduced, copied" >> "${file}"
    echo " * or revised without written permission of the authors." >> "${file}"
    echo " *" >> "${file}"
    echo " * Author: Jules Klein <klein@ecole.ensicaen.fr>" >> "${file}"
    echo " * Version 1.0 $(date +%d/%m/%Y)" >> "${file}"
    echo " */" >> "${file}"
}

# this function formats C header files
add_hc_header () {
    file=$1
    name_var_ifndef=$(echo "${file:: -2}" | tr [a-z] [A-Z])
    echo "#ifndef ${name_var_ifndef}_H" >> "${file}"
    echo "#define ${name_var_ifndef}_H" >> "${file}"
    echo "" >> "${file}"
    echo "#include <stdio.h>" >> "${file}"
    echo "" >> "${file}"
    echo "" >> "${file}"
    echo "" >> "${file}"
    echo "#endif" >> "${file}"
}


if [ $# -ne 1 ]
then
   echo "Use : sethc.sh file"
   exit 0
fi

if [ ! -f $1 ]
then
    echo "The file $1 does not exist"
    exit 0
fi

file=$1
extension=${file: -3} # gets the last 3 characters of the string contained in $file
extc=".\.c"
exth=".\.h"


if [ "${extension}" = ".sh" ]
then
    test_empty "${file}"
    add_hc_shell "${file}"
    echo "${file} was correctly formated (shell script)"
    exit 0
elif [[ ${extension} =~ ${extc} ]]
then
    test_empty "${file}"
    add_hc_c "${file}"
    echo "${file} was correctly formated (C source file)"
    exit 0
elif [[ ${extension} =~ ${exth} ]]
then
    test_empty "${file}"
    add_hc_header "${file}"
    echo "${file} was correctly formated (C header file)"
    exit 0
elif [ "${extension}" = ".py" ]
then
    test_empty "${file}"
    add_hc_python "${file}"
    echo "${file} was correctly formated (python script)"
else
    echo "File extension not recognized"
fi
