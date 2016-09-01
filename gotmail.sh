#!/bin/bash
clear
################################################################################################
## This script will brute force email recipients/users on the system using sendmail port 25    #
## $1 input is server IP or Domain                                                             #
## $2 is your wordlist of names to try                                                         #
## !!WARNING!! THIS MAY CRASH SENDMAIL OR CAUSE IT TO STOP RESPONDING OR BE BANNED BY IDS!     #
################################################################################################

if [ -z "$1" ]; then
	echo ""
	echo "   Usage: gotmail.sh <target-ip-or-domain> <wordlist of names to brute> <*optional* - site name used for unique output files>"
	echo "   Exmaple: gotmail.sh 10.10.10.10 /usr/share/wordlists/dirb/common.txt   sitename"
	echo ""
	echo "   !!WARNING!! THIS MAY CRASH SENDMAIL OR CAUSE IT TO STOP RESPONDING OR BE BANNED BY IDS! "
    exit
fi

##   initilize finds !! This overwrites results - move old files first before running or set unique name to save
echo "!!WARNING!! THIS MAY CRASH SENDMAIL OR CAUSE IT TO STOP RESPONDING OR BE BANNED BY IDS! "
echo "You have 10 seconds to stop now (ctrl+c)! Small lists usually do fine, larger use at your own risk! "
sleep 10
clear
echo "#####################################################################################" > ./$3-mail-loot.txt
echo "##  [+] These are all of the email addresses we have found to exist on the system.  #" >> ./$3-mail-loot.txt
echo "##  [+] These could be potential logins for the system as well                      #" >> ./$3-mail-loot.txt
echo "#####################################################################################" >> ./$3-mail-loot.txt
echo "" >> ./$3-mail-loot.txt

echo "helo $1" > ./rcpt.txt
echo "mail from: <>"  >> ./rcpt.txt

	while read -r name; do
	    echo "rcpt to: $name" >> ./rcpt.txt
	done < $2

echo "quit" >> ./rcpt.txt
echo "" >> ./rcpt.txt
count=$(wc ./rcpt.txt | awk '{print $1}');
echo ""
echo "    [+] Number of items to lookup: $count                                            "
echo "_____________________________________________________________________________________" 
cat ./$3-mail-loot.txt

sleep 5 ## If too large and fast netcat doesn't see the finished list so we sleep 4

netcat -nv $1 25 < ./rcpt.txt | egrep "2(.*)ok" | cut -d " " -f 3 | sed -r 's/[<>\.]+//g' >> ./$3-mail-loot.txt
sleep 10
rm ./rcpt.txt

clear
count2=$(wc ./$3-mail-loot.txt | awk '{print $1}');
echo ""
echo "    [+] $count2 items found out of $count."
echo "_____________________________________________________________________________________"
cat ./$3-mail-loot.txt

#optional open file. comment out if you don't have xdg-open on your system.
#xdg-open ./$3-mail-loot.txt

exit

