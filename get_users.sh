#!/bin/sh
echo off
token=$(jq -r ".token" token.json)
# switch a = show all invoices in descending date order, else show only pending invoices in ascending date order (created_at)
max_pages=200 #maximum number of results per page (200 is the limit set by Mavenlink)
users=$(curl -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/users?on_my_account=true&per_page='$max_pages'&page=1')
user_count=$(jq -n "$users" | jq -r '.count')
page_count=$(jq -n "$users" | jq -r '.meta.page_count')

if [ $user_count == 0 ]; then
  echo "No users found!"
else
  if [ $1 == "w" ]; then
    echo ""
    echo "Writing file: users.CSV"
    #write CSV header
    echo "user_id,full_name,email,job_title" > users.csv
    #if number of pages > than 1, iterate through
    for (( i=1; i < $((page_count+1)); ++i ))
      do
        if [ $i != 1 ]; then
          users=$(curl -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/users?on_my_account=true&per_page='$max_pages'&page='$i)
          user_count=$(jq -n "$users" | jq -r '.count')
        fi
        #iterate the users list per page
        for (( j=0; j < $user_count; ++j ))
          do
            id=$(jq -n "$users" | jq -r '.results['$j'].id')
            if [ $id != null ]; then
              #append CSV user data by line
              echo '"'$id'","'$(jq -n "$users" | jq -r '.users["'$id'"].full_name')'","'$(jq -n "$users" | jq -r '.users["'$id'"].email_address')'","'$(jq -n "$users" | jq -r '.users["'$id'"].headline')'"' >> users.csv
            fi
          done #end users list iteration
        done #ends page iteration
      echo ""
      echo "Done!"
    else
      echo ""
      echo "######################## User List ######################"
      echo "This is a sample view only list to write it out to a CSV,"
      echo "run he script with the w switch: ./get_users.sh w"
      echo "#########################################################"
      echo ""
      for (( i=0; i < $user_count; ++i ))
        do
          id=$(jq -n "$users" | jq -r '.results['$i'].id')
          if [ $id != null ]; then
            echo "[" $id "] "$(jq -n "$users" | jq -r '.users["'$id'"].full_name')" "$(jq -n "$users" | jq -r '.users["'$id'"].email_address')" "$(jq -n "$users" | jq -r '.users["'$id'"].headline')
          fi
        done
    fi
  echo ""
fi
