#!/bin/sh
#
# ENSICAEN
# 6 Boulevard Maréchal Juin
# F-14050 Caen Cedex
#
# Author: Jules Klein <klein@ecole.ensicaen.fr>
# Version 1.0 30/10/2019
#
#
# This script manages creation, deletion, archiving and compilation of
# C projects.
#
#
# use : ./cprojman.sh

# TODO : add check for existence of sethc.sh

menu () {
    echo "C project skeleton generator"
    echo "============================"
    echo "N|n) create a new project"
    echo "D|d) delete a project"
    echo "C|c) compile a project"
    echo "A|a) archive a project"
    echo "E|e) exit"
}

delete () {
    echo "Please enter the path of the project"
    read path
    echo "deleting ${path}, are you sure ?"
    read sure
    case ${sure} in
	"Y"|"y")
	    rm -dR ${path}
	    echo "${path} deleted"
	    ;;
	*) echo "aborting"
	   ;;
    esac
}

archive () {
    echo "Enter the path of the project"
    read path
    echo "Enter the name of the archive"
    read arch

    cd ${path}
    tar -cvf ${arch} *

    echo "archive created."
}

compile () {
    echo "Enter the path of the project"
    read path
    echo "Enter the name of the executable"
    read exe

    cd ${path}
    gcc -Wall -Wextra -ansi -pedantic *.c -o ${exe}

}

create () {
    echo "Enter the path of the project"
    read path
    echo "Enter the name of the project"
    read name

    cur_path=$(pwd)
    
    cd ${path}
    mkdir ${name}

    cd ${name}
    mkdir include
    mkdir source
    mkdir doc

    touch README.md
    touch LICENSE

    cd source
    touch main.c

    ${cur_path}/sethc.sh main.c

    echo "${path}/${name} files created."
}

menu

while :
do
    echo "?"
    read choice
    case ${choice} in
	"N"|"n") create
		 ;;
	"D"|"d") delete
		 ;;
	"C"|"c") compile
		 ;;
	"A"|"a") archive
		 ;;
	"E"|"e") exit 0
		 ;;
	*) echo "wrong command"
	   ;;
    esac
done
