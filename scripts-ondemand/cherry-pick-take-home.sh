#! /bin/bash

####################
## Description
##
##  Once the candidate has completed the take-home, run this script.
##  It will cherry-pick the commits and open a pull request
##
## Usage
##
##  cherry-pick-take-home <candidate-name>
##  cherry-pick-take-home <candidate-name> <remote-branch> <local-branch>
##
## Arguments
##
##  candidate-name: The name of the candidate's repository. It should be the same as the repository name on GitHub.
##  remote-branch: (optional) The name of the remote branch to cherry-pick from (default: master)
##  local-branch: (optional) The name of the local branch to create (default: solutions/<candidate-name>)
##
## Platforms tested: zsh
##
## Installation
##
##  1. Install `gh` cli: https://cli.github.com/
##  2. Edit your .bashrc or .zshrc and add `source path/to/cherry-pick-take-home.sh`
##  3. Move to the root of the `take-home-project` repository
##  4. Run the script with the candidate's name
##
####################
function cherry-pick-take-home() {
    if (($# < 1 || $# > 3)); then
        echo "Usage: cherry-pick-take-home <candidate-name>"
        return
    fi

    local candidate_name=$1
    local remote_branch=${2:-"master"}
    local local_branch=${3:-"solutions/$candidate_name"}
    local candidate_repo="git@github.com:maintainx-take-home/$candidate_name.git"

    # Save any changes
    git stash

    # Add remote
    git remote remove $candidate_name
    git remote add $candidate_name $candidate_repo;
    if ((!$? == 0)); then
        echo "Failed to add remote $candidate_name. Check if the repository exists."
        return 1
    fi

    # Fetch remote
    git fetch "$candidate_name"
    if ((!$? == 0)); then
        echo "Failed to fetch remote $candidate_name. Check if the repository exists."
        return 1
    fi

    echo "Fetch commits on $candidate_name/$remote_branch"

    # Get a list of commits from start to end, excluding merge commits
    local commits=($(git log $candidate_name/$remote_branch --reverse --no-merges --pretty=format:"%H"))

    # Remove the first element (initial commit)
    commits=("${commits[@]:1}")

    # Commit count
    local count=${#commits[@]}
    if ((count == 0)); then
        echo "No commits to cherry-pick"
        return 1
    fi
    echo "Cherry-picking $count commits from $candidate_name/$remote_branch to $local_branch"

    # Create local branch
    git checkout master
    git branch -D $local_branch
    git checkout -b $local_branch

    local has_conflicts=

    # Cherry-pick each commit
    for commit in "${commits[@]}"; do
        git cherry-pick $commit

        if ((!$? == 0)); then
            has_conflicts=1
            echo -e "\nCherry-pick failed for commit $commit."
            echo "In another terminal, fix the conflicts, then run \`git add\` and \`git cherry-pick --continue\`."
            echo "Then return to this terminal and continue."
            __cherry-pick-take-home-confirm || return 1
        fi
    done

    if [[ "$has_conflicts" == 1 ]]; then
        echo -e "\n"
        importanttext "Sanity check..."
        echo

        warningtext "Summary of changes in maintainx-take-home:"
        boldtext "git diff --stat $(git rev-list --max-parents=0 $candidate_name/$remote_branch)...$candidate_name/$remote_branch"
        git diff --stat $(git rev-list --max-parents=0 $candidate_name/$remote_branch)...$candidate_name/$remote_branch

        warningtext "\nSummary of changes in take-home-project:"
        boldtext "git diff --stat master...$local_branch"
        git diff --stat master...$local_branch

        echo
        __cherry-pick-take-home-confirm "Does that look right to you? [y/n]" || return 1

        warningtext "\nDiff between maintainx-take-home and take-home-project:"
        boldtext "git diff $local_branch $candidate_name/$remote_branch"
        git diff $local_branch $candidate_name/$remote_branch

        echo
        __cherry-pick-take-home-confirm "Does that look right to you? [y/n]" || return 1
    fi

    # Push to remote
    git push origin -d $local_branch 2> /dev/null
    git push origin $local_branch

    # Ensure we push on the correct repository
    gh repo set-default maintainx/take-home-project

    # Open a pull request
    gh pr create --base master --web
}

function __cherry-pick-take-home-confirm() {
    local text=${1:-"Continue? [y/n]"}
    while :; do
        __cherry-pick-take-home-prompt "$text"
        if [[ $REPLY =~ ^[Nn]$ ]]; then
            echo "Exiting"
            return 1
        fi
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            return 0
        fi
        echo 'Please enter "y" or "n"'
    done
}

function __cherry-pick-take-home-prompt() {
    local text=$1
    if [[ -n "$ZSH_VERSION" ]]; then
      read -r "?$text "
    else
      read -rp "$text "
    fi
}

function boldtext() {
    echo -e "\e[1m$@\e[0m"
}
function warningtext() {
    echo -e "\e[31;1m$@\e[0m"
}
function importanttext() {
    echo -e "\e[41;1m$@\e[0m"
}