#!/bin/sh

############
# The following script is to help automate deployment of hugo sites on github pages. 
# If you're just getting started, I recommend reading my full notes here: 
# https://www.romandesign.co/setting-up-a-hugo-static-site-on-github/
# 
# To run it, make sure you have made some site updates to deploy and via terminal in your backend and save the code in your hugo backend repo. 
# Then type the following (no $):
#
# 	$ chmod +x deploy.sh  #### This will make your script executable. You only need to type this once to modify permissions.
#    	$ ./deploy.sh "Your optional commit message"   #### This will actually run the code. 
#
############


# If a command fails then the deploy stops
set -e

# Just a tooltip to let you know the script is running.
printf "\033[0;32m>> Deploying updates to GitHub...\033[0m\n" 

# Build the hugo site to both of your repos
hugo -t navigator-hugo # This builds the public site into public/ folder.

# Deploy your public site
printf "\n\033[0;32m>> Staging all the files...\033[0m\n"
cd public/ # Goes to your public site repo
git add . # Adds changes

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

printf "\n\033[0;32m>> Adding the commit with message: '$msg'\033[0m\n"
git commit -m "$msg" # Makes your commit with the message from your deploy script execution

printf "\n\033[0;32m>> Pushing changes to 'main' branch...\033[0m\n"
git push origin main # Pushes the code to GitHub

# Come back to the root folder
cd ..