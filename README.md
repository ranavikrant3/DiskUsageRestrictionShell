# DiskUsageRestrictionShell
#### Add this script to your /etc/profile (source it). BE CAREFUL AS THIS STEP SHOULD ONLY BE DONE IN CASE OF A SERVER ACCESSED USING A COMMAND LINE. DOING IT TO A SYSTEM WITH GUI MIGHT CAUSE THE USER UNABLE TO LOGIN. This should automatically test the disk usage on each user's login. In case the usage is over 6GB, the user will be restricted with only some basic commands for listing, deleting etc. In order to gain the fully function shell, the size must be reduced below 6GB.
#### There is also a backdoor/cheatcode for escaping the script's jail just in case something goes wrong. The cheatcode is godmodeforroot
#### Feel free to modify it as per your usecase.
