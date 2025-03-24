#!/bin/bash
# custom variables
export JIRA_PROJECT="PFM"
export GITHUB_REVIEWER="MaintainX/enterprise-platform-api"
export GH_TOKEN=$GH_TOKEN

# bump
function bump-interactive(){
    # prevent losing work
    git add .
    git stash

    # make sure we're on master
    git checkout master
    git pull

    # create dependencies branch
    local branch_name="$MX_SLUG/$JIRA_PROJECT-update-dependencies"
    git branch -D $branch_name
    git checkout -b $branch_name
    
    # upgrade
    yarn upgrade-interactive

    # dedupe
    yarn dedupe

    # commit and push
    local pr_title="[$JIRA_PROJECT] Weekly update dependencies - $(date '+%b %d, %Y')"
    yarn run changelog-add --description "$pr_title" --jira-issue "$jira"
    git add .
    git commit -m "$pr_title"
    git push

    # open PR
    gh pr create --assignee @me --body "" --reviewer $GITHUB_REVIEWER --label "dependencies" --title $pr_title
}