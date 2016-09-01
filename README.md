# gotmail
Enumerate users and names over SMTP (Port 25) via open Sendmail service

Example: 
  
    root@digip:~/gotmail.sh 10.10.10.10 ./sample-wordlist sitename
  
Note: 'sitename' is optional. If none given, files will be overwritten on next run.

[WARNING]
Large lists CAN crash sendmail, or, get you banned by IDS. Smaller lists work quickly. 
Under 5000 names is generally good enough. +9000 https://www.youtube.com/watch?v=SiMHTK15Pik

Use only on systems you have permission to test on!
