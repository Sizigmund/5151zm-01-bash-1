#!/bin/bash

# Description
echo "Simple Package Tracker"
echo "A script for rpm package tracking by name."
echo "by Mykhailo Buianskyi"

# Main loop
quit="N"
while [ "$quit" = "N" ]; do
	read -p "Enter package name: " pkg
	if [[ $((yum info installed $pkg) 2>&1 | grep "Error") ]]; then 
		echo "$pkg not installed."
		if [[ $((yum info available $pkg) 2>&1 | grep "Error") ]]; then
			echo "$pkg not found. Try another."
		else
			echo "$pkg is found."
			read -p "Install $pkg? [Y/n] " ans
			ans=`echo $ans | tr yn YN` # to upper case
			if [ "$ans" = "Y" ]; then
				sudo yum install $pkg
			elif [ "$ans" != "N" ]; then
				(echo "Error: Unknown command..." 1>&2)
			fi
		fi
	else
		yum info installed $pkg
	fi

	# Quit-question loop
	quit=""
	while [ "$quit" != "Y" -a "$quit" != "N" ]; do
		read -p "Would you like to quit? [Y/n] " quit
		quit=`echo $quit | tr yn YN`
	done
done
