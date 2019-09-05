#!/bin/sh
echo off
token=$(jq -r ".token" token.json)
export IFS=","
cat users_skills.CSV | while read f1 f2 f3 f4
  do
    #check for empty level field value
    if [ x$f4 == x ]; then
      f4=1
    fi
    #discard first line based on the value of field 3 skill_id
    if [ $f3 != "skill_id" ]; then
      curl -X POST -H 'Authorization: Bearer '$token -H "Accept: Application/json" -H "Content-Type: application/json" "https://api.mavenlink.com/api/v1/skill_memberships" -d '{ "skill_membership": {	"skill_id": '$f3', "user_id":'$f1',	"level":'$f4'	}}' >> $(date +%Y"-"%m"-"%d)_log.txt
      echo ""
      echo $f4
      echo ""
    fi
  done
