#!/bin/bash
function bump-everything(){
  local repositories=(
    "notification-service"
    "mx-zapier"
  )

  # make sure we can reach the npm private registry
  aws sso login

  for repository in "${repositories[@]}"
  do
    echo "Bumping $repository"
    cd ~/projects/$repository
    bump-interactive
  done

  echo "Done"
}