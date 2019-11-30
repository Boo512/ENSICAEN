#!/bin/sh
#
# ENSICAEN
# 6 Boulevard Maréchal Juin
# F-14050 Caen Cedex
#
# Author: Jules Klein <klein@ecole.ensicaen.fr>
# Version 2.0 29/11/2019
#
#
# This script sets the correct comments (and #ifndef stuff if .h)
# at the start of a file, depending on the extension
# It accepts .sh, .c, .h, .py
#
#
# USE : sethc -[c|h|sh|py] file
#
# TODO :
#
# CHANGELOG : + Changed recognition of file extension to use of an
#               option to specify it


# this function tests if the file is empty and if not asks to erase it
test_empty () {
    if [ -s "$1" ]
    then
       while :
       do
	   echo "the file is not empty. Do you want to erase it (y/n) ?"
	   read -r choice
	   case "$choice" in
	       "y"|"Y") cat /dev/null > $1
			echo "$1 was successfully erased"
			break
			;;
	       "n"|"N") echo "Aborting !"
			exit 0
			;;
	       *) echo "Invalid answer"
		  exit 0
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
    echo " /** ENSICAEN" >> "${file}"
    echo " * 6 Boulevard Maréchal Juin" >> "${file}"
    echo " * F-14050 Caen Cedex" >> "${file}"
    echo " *" >> "${file}"
    echo " * This file is owned by ENSICAEN." >> "${file}"
    echo " * No portion of this document may be reproduced, copied" >> "${file}"
    echo " * or revised without written permission of the authors." >> "${file}"
    echo " *" >> "${file}"
    echo " * @Author: Jules Klein <klein@ecole.ensicaen.fr>" >> "${file}"
    echo " * @Version 1.0" >> "${file}"
    echo " * @date $(date +%d/%m/%Y)" >> "${file}"
    echo " */" >> "${file}"
}

# this function formats C header files
add_hc_header () {
    file=$1
    name_var_ifndef=$(echo "${file}" | tr [a-z.] [A-Z_])
    echo "#ifndef ${name_var_ifndef}" >> "${file}"
    echo "#define ${name_var_ifndef}" >> "${file}"
    echo "" >> "${file}"
    echo "#include <stdio.h>" >> "${file}"
    echo "" >> "${file}"
    echo "" >> "${file}"
    echo "" >> "${file}"
    echo "#endif" >> "${file}"
}

#test if command is valid
if [ $# -ne 2 ]
then
   echo "Use : sethc.sh -[c|h|py|sh] file"
   exit 0
fi

#test if file exists
if [ ! -f $2 ]
then
    echo "The file $1 does not exist"
    exit 0
fi

arg=$1
file=$2

#test if arg is valid
if [ "${arg}" != "-c" -a "${arg}" != "-h" -a "${arg}" != "-py" -a "${arg}" != "-sh" ]
then
    echo "Use : sethc.sh -[c|h|py|sh] file"
fi

#script core
if [ "${arg}" = "-c" ]
then
    test_empty "${file}"
    add_hc_c "${file}"
    echo "${file} was correctly formated (C source file)"
    exit 0
elif
    [ "${arg}" = "-h" ]
then
    test_empty "${file}"
    add_hc_header "${file}"
    echo "${file} was correctly formated (C header file)"
    exit 0
elif
    [ "${arg}" = "-py" ]
then
    test_empty "${file}"
    add_hc_python "${file}"
    echo "${file} was correctly formated (python script file)"
    exit 0
elif
    [ "${arg}" = "-sh" ]
then
    test_empty "${file}"
    add_hc_shell "${file}"
    echo "${file} was correctly formated (shell script file)"
    exit 0
fi
