# Skills Membership - Sample Shell Script - Mac/Linux Version #

This shell script (Mac/Linux) uses a Mavenlink API endpoint to update skill membership in an account from a CSV file. There are also a couple of supporting scripts in this bundle to retrieve skills and user lists, which can be used to prepare the CSV needed by the main script.

## Pre-Requisites ##

  1. Make the shell scripts executable
      - Navigate to the folder where you cloned the scripts (E.G: cd ~/Documents/ML-Skills-Membership-sample-script)
      - Run this code (inside that folder only): chmod +x *.sh
  2. Linux: Install JQ via your distribution's application manager. eg: apt-get install jq
  3. Mac: Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
     - run the setup script: ./setup.sh (follow the prompts)
  4. Rename the file sample_token.json to token.json and update it with with your Mavenlink API token

## Data prep ##

  1. open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd ~/Documents/ML-Skills-Membership-sample-script
  3. Run the script: ./get_skills.sh and ./get_users.sh
  4. Follow the instructions on the prompt
  5. Save the file users_skills_sample.txt as users_skills.csv, which will be used by the next script to update Mavenlink. (keep CSV and Scripts in the same folder)
  6. Use the files skills.csv and users.csv, created by the two scripts above to populate the users_skills.csv file.
      - test the script with a small set of data to ensure everything is correct
      - you can see the results on a dated log file in the same folder as the script

## Running the script ##

  1. Open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd ~/Documents/ML-Skills-Membership-sample-script
  3. Run the script: ./set_skills.sh
      - this script uses the users_skills.csv file updated in the previous step. Please ensure the file and script are in the same folder.
  4. Follow the instructions/output on the prompt
  5. View results/response on log file in the same folder as the script (yyy-mm-dd_log.txt)

  Disclaimer: These scripts are provided as sample code and they are NOT official Mavenlink tools, but generated as part of an exercise to investigate the use of Mavenlink's API based on specific scenarios. The developer accepts no liability for any issues that could arise from using these scripts.
