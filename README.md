# Invoices - Sample Shell Script - Mac/Linux Version #

This shell script (Mac/Linux) uses a Mavenlink API endpoint to view all the invoices in an account, which is granted by your access token (see instructions below).

## Pre-Requisites ##

  1. Make the shell scripts executable
      - Navigate to the folder where you cloned the scripts (E.G: cd ~/Documents/ML-Invoices-shell)
      - Run this code (inside that folder only): chmod +x *.sh
  2. Linux: Install JQ via your distribution's application manager. eg: apt-get install jq
  3. Mac: Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
     - run the setup script: ./setup.sh (follow the prompts)
  4. Rename the file sample_token.json to token.json and update it with with your Mavenlink API token

## Running the script ##

  1. Open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd ~/Documents/ML-Invoices-sample-shell
  3. Run the script: ./get_invoice.sh
  4. Follow the instructions on the prompt
  5. View all invoices: By default the script will only show pending invoices, to see all invoices add the switch "a". EG:  ./get_invoice.sh a
