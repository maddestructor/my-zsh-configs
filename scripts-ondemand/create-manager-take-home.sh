#! /bin/bash

####################
## Description
##
##  It creates the manager take-home repository from a template then, cherry-picks the solutions
##  and opens a pull request for each candidate.
##
## Usage
##
##  create-manager-take-home <candidate-name>
##  create-manager-take-home bobby-bobbinson
##
## Arguments
##
##  candidate-name: The name of the candidate's repository. It should be the same as the repository name on GitHub.
##
## Platforms tested: zsh
##
## Installation
##
##  1. Install `gh` cli: https://cli.github.com/
##  2. Edit your .bashrc or .zshrc and add `source path/to/create-manager-take-home.sh`
##  3. Move to your repostiories folder
##
####################
function create-manager-take-home() {
    if (($# < 1)); then
        echo "Usage: create-manager-take-home <candidate-name>"
        return
    fi

    local candidate_name=$1

    local repo_url
    local repo_name

    echo Creating repostitory for candidate "$candidate_name"

    gh repo create "$candidate_name" --template maintainx/take-home-project --private --clone

    repo_url=$(gh repo view "$candidate_name" --json url --jq '.url')
    repo_name=$(echo "$repo_url" | cut -d'/' -f5)

    cd "$repo_name" || exit

    gh repo set-default || exit

    git remote add og git@github.com:MaintainX/take-home-project.git
    git fetch og

    # Candidate 1 — https://github.com/MaintainX/take-home-project/pull/173
    git checkout -b solutions/candidate-1
    git cherry-pick -X theirs og/master..og/eng-manager/candidate-1
    git push

    gh pr create --base master --title "Bobby Bobbinson's Solution" --body ""

    # Candidate 2 — https://github.com/MaintainX/take-home-project/pull/184
    git checkout master
    git checkout -b solutions/candidate-2
    git cherry-pick -X theirs og/master..og/eng-manager/candidate-2
    git push

    gh pr create --base master --title "Fred Franklin's Solution" --body ""

    echo "Repository created at $repo_url, invite candidate and reviewers to the repository"
    echo "Then, transfer ownership to maintainx-take-home"
}