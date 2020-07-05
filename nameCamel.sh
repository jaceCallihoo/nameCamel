#! /usr/bin/bash

# quick change mode

# opening text graphic
echo -E  "_______   __                      _________                                 ______
_____  | / /_____ _______ __________  ____/_____ _______ __________ ___________  /
____   |/ /_  __ \`/_  __ \`__ \\  _ \\  /    _  __ \`/_  __ \`__ \\_  __ \`__ \\  _ \\_  /
___  /|  / / /_/ /_  / / / / /  __/ /___  / /_/ /_  / / / / /  / / / / /  __/  /
__/_/ |_/  \\__,_/ /_/ /_/ /_/\\___/\\____/  \\__,_/ /_/ /_/ /_//_/ /_/ /_/\\___//_/   "

echo "
                              ,,__
                    ..  ..   / o._)                   .---.
                   /--'/--\  \-'||        .----.    .'     '.
                  /        \_/ / |      .'      '..'         '-.
                .'\  \__\  __.'.'     .'          '-._
                  )\ |  )\ |      _.'
                 // \\ // \\
                ||_  \\|_  \\_
                '--' '--'' '--'"

echo -n -e "\n\n\n"

# select root directory

DIR="" # root directory of the changes

while read -p "Would you like to navigate to a different directory? [y/n] " INP
do
	case "$INP"
	in
		[Yy] | [Yy][Ee][Ss]) # read user input of directory
			while read -p "Enter the path of the desired directory [PATH/r] " PATH
			do
				# check if input is a path: if so set DIR and break
				if [ -d "$PATH" ]; then DIR="$PATH"; break; fi

				# check if input is an action
				case "$PATH" in
					[Rr] | [Rr][Ee][Tt][Uu][Rr][Nn]) break ;;
					[Qq] | [Qq][Uu][Ii][Tt]) echo "Goodbye"; exit ;;
					*) echo "Pleas enter a valid directory path" ;;
				esac
			done
			if [ "$DIR" != "" ]; then break; fi ;;	# if DIR is set (the return option wasn't taken): break

		[Nn] | [Nn][Oo]) DIR=$(pwd); break ;;		# use currend working directory as DIR
		[Qq] | [Qq][Uu][Ii][Tt]) echo "Goodbye"; exit ;;			# end program
		*): echo "Please enter y/yes or n/no" ;;	# false input
	esac
done

cd "$DIR"		#move to the assigned directory

# get list of files in directory

declare -a FILES
echo -e "\nFiles in directory $PWD:"
for ITEM in *
do
	if [ -f "$ITEM" ]
	then
		FILES[${#FILES[@]}+1]=${ITEM}
		echo ") $ITEM"
	fi
done

echo


# nameCammel function: takes a name of file in $1 and returns it's camel case version in NAMECAMMEL
nameCamel() {

	# capitalize every letter after a space or underscore or number
	local I=0
	local CHAR=${1: 0: 1}
	local CAPITALIZE_NEXT=false
	while [[ "$I" -lt "${#1}" && "$CHAR" != "." ]]
	do
		if [[ "$CHAR" =~ ^[a-z]$ || "$CHAR" =~ ^[A-Z]$ ]]		# letter
		then
			if [[ "$I" -eq 0 ]] 			# if its the first character
			then
				NAMECAMMEL+="${CHAR,}"		# make it lower case
			elif [[ "$CAPITALIZE_NEXT" = true ]]
			then
				NAMECAMMEL+="${CHAR^}"		# make it lower case
				local CAPITALIZE_NEXT=false
			else
				NAMECAMMEL+="${CHAR}"
			fi
		elif [[ "$CHAR" =~ ^[0-9]$ ]]		# number
		then
			local CAPITALIZE_NEXT=true
			NAMECAMMEL+="${CHAR}"
		else								# other
			local CAPITALIZE_NEXT=true
		fi

		# increment the character
		let "I+=1"
		local CHAR=${1: $I: 1}
	done

	# add the file extension to the name
	NAMECAMMEL+=${1: $I}
}

# confirm changes
while read -p "Would you like to confirm the change of these files? [y/n] " INP
do
	case "$INP"
	in
		[Yy] | [Yy][Ee][Ss]) # change file names and exit

			for I in ${!FILES[@]}
			do
				NAMECAMMEL=""
				nameCamel "${FILES[$I]}"
				/bin/mv -nvT "${FILES[$I]}" "$NAMECAMMEL"
			done

			echo -e "\nExecution complete!"
			echo "Goodbye"
			exit
			;;

		[Nn] | [Nn][Oo]) echo "Goodbye"; exit ;;			# end program
		[Qq] | [Qq][Uu][Ii][Tt]) echo "Goodbye"; exit ;;	# end program
		*): echo "Please enter y/yes or n/no" ;;	# false input
	esac
done










# for FILE in ${FILES[@]}
# do
# 	echo "$FILE"
# 	# if [  ] # if the name can be changed
# 	# then
# 	# 	SUCCESSFILES+="$FILE "
# 	# else
# 	# 	FAILEDFILES+="$FILE "
# 	# fi
# done
# these are the files that could not be changed
# echo "These are the files that can not be changed:"
# for FILE in $FAILEDFILES
# do
# 	echo "$FILE"
# done
#
# # these are the files that would be changed: (confirm change)
# echo "These are the files that will be changed:"
# for FILE in $SUCCESSFILES
# do
# 	echo "$FILE"
# done
#
# while read -p "Confirm the changes [y/n] " INP
# do
# 	case "$INP"
# 	in
# 		[Yy] | [Yy][Ee][Ss])
#
# 			for FILE in $SUCCESSFILES
# 			do
# 				mv FILE CAMEL_FILE
# 			done
#
# 			break
# 			;;
#
# 		[Nn] | [Nn][Oo]) break ;;
# 		[Qq] | [Qq][Uu][Ii][Tt]) exit ;;			# end program
# 		*): echo "Please enter y/yes or n/no" ;;	# false input
# 	esac
# done
#
# # change complete
#
# nameCamel() {
#
# 	local FILE="$1"
#
#
#
# }
