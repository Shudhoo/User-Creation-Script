#!/bin/bash

# This script create user and user's password automatically
# This will help creating user in more automated way
# We will try to modify the script with some emil configurations and add same user to a particular group in the next version of this Script !!
#
# Author: Shudhodhan
# Team: DevOps
# Version: v1
#
# *This script can be only run by Admin or Root User*

if [[ "$UID" -ne 0 ]]
then 
	echo "This Script can only run by root user or root previliges"
	exit 1
fi

if [[ "$#" -lt 1 ]]
then
	echo "Please add USERNAME & COMMENTS"
	echo "Usage: ${0} USERNAME [COMMENTS]"
	exit 1
fi

#What this do is stores username in "UserName" and following the username are comments the shift keywords adds anything following UserName will pass to Comment
#
UserName="${1}"
shift
Comment="${@}"

#Create Password
Pass=$(date +%s%N)

#Creating user
useradd -c "{$Comment}" -m $UserName

if [[ $? -ne 0 ]]
then
	echo "User Creation Failed, Try again later"
	exit 1
fi

#Setting password for user
echo "$UserName:$Pass" | chpasswd

#Check if the password set or not
if [[ $? -ne 0 ]]
then
	echo "Password could not be set, try again later"
	exit 1
fi

#Force Password change on 1st login
passwd -e $UserName

#Display all the details
echo
echo "User Name: $UserName"
echo 
echo "Password: $Pass"
echo 
echo $(hostname)

