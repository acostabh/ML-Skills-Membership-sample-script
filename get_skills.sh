#!/bin/sh
echo off
token=$(jq -r ".token" token.json)
# switch a = show all invoices in descending date order, else show only pending invoices in ascending date order (created_at)
max_page=200 #maximum number of results per page (200 is the limit set by Mavenlink)
skills=$(curl -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/skills?per_page='$max_page'&page=1')
skills_count=$(jq -n "$skills" | jq -r '.count')
page_count=$(jq -n "$skills" | jq -r '.meta.page_count')
echo $page_count
if [ $skills_count == 0 ]; then
  echo "No skills found!"
else
  #looking for the write switch 'get_skills.sh w' to enable writting to CSV
  if [ $1 == "w" ]; then
    echo ""
    echo "Writing file: skills.CSV"
    echo "skill_id,skill,max_level" > skills.csv
    #if number of pages > than 1, iterate through
    for (( i=1; i < $((page_count+1)); ++i ))
      do
        if [ $i != 1 ]; then
          skills=$(curl -H 'Authorization: Bearer '$token 'https://api.mavenlink.com/api/v1/skills?per_page='$max_page'&page='$i)
          skills_count=$(jq -n "$skills" | jq -r '.count')
        fi
        #iterate the skills list per page
        for (( j=0; j < $skills_count; ++j ))
          do
            id=$(jq -n "$skills" | jq -r '.results['$j'].id')
            if [ $id != null ]; then
              echo '"'$id'","'$(jq -n "$skills" | jq -r '.skills["'$id'"].name')'","'$(jq -n "$skills" | jq -r '.skills["'$id'"].max_level')'"' >> skills.csv
            fi
          done #end skills list iteration
      done #ends page iteration
      echo ""
      echo "Done!"
    else
      echo ""
      echo "#################### Skills List #########################"
      echo "This is a sample view only list to write it out to a CSV, "
      echo "run he script with the w switch: ./get_skills.sh w"
      echo "##########################################################"
      echo ""
      for (( i=0; i < $skills_count; ++i ))
        do
          id=$(jq -n "$skills" | jq -r '.results['$i'].id')
          if [ $id != null ]; then
            echo "[" $id "] "$(jq -n "$skills" | jq -r '.skills["'$id'"].name')" Max level: "$(jq -n "$skills" | jq -r '.skills["'$id'"].max_level')
          fi
        done
    fi
  echo ""
fi
