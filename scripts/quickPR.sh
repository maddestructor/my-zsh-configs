#! /bin/bash

# custom variables
export JIRA_PROJECT="PFM"
export GH_SLUG="maddestructor"

####################
## Usage
## quickPR <JIRA ticket> <title>
## quickPR PFM-123 Add new feature       # Creates a PR with changelog linked to PFM-123
## quickPR 123 Add new feature            # Creates a PR with changelog linked to $JIRA_PROJECT-123
## quickPR 000 Fixed this annoying thing  # Creates a PR with changelog linked to a new JIRA ticket
##
## Installation
## 1. Add this function to your .bashrc or .zshrc
## 2. Install `gh` cli: https://cli.github.com/
## 3. Install `jira-cli`: https://github.com/MaintainX/mx-jira/blob/master/packages/jira-cli/README.md
## 4. Install `mxt`: https://github.com/MaintainX/mx-tools?tab=readme-ov-file#installation
####################
function quickPR() {
  local jira=$1
  # Title is everything after the first space
  local title=${*:2}

  # Error if JIRA ticket and title are missing
  if [[ -z "$jira" || -z "$title" ]]; then
    echo "Usage: quickPR <JIRA ticket> <title>"
    return 1
  fi
  # TODO:: Ensure `yarn changelog-add` is available in the current path

  # If jira ticket is only zeros then
  # call script "jira-cli" and parse output for "Issue created: <PROJECT>-<ISSUE_KEY>" to extract the Jira ticket
  # Follow installation instructions at https://github.com/MaintainX/mx-jira/blob/186b0df4052779b5d1628bce99461da4c20d06d4/packages/jira-cli/README.md
  if [[ "$jira" =~ ^[0]+$ ]]; then
    local out=
    out=$(jira-cli issue create --project "$JIRA_PROJECT" --summary "$title" --status "InProgress" --sprint "@active" --issueType Task)
    jira=$(echo "$out" | grep -oEI 'Issue created: (\w+-\w+)' | sed 's/Issue created: //g')
  fi;
  echo "JIRA: $jira"

  # make sure we can reach the npm private registry
  mxt utils aws-check
  # aws sso login # Alternative if you don't have mxt installed... but you should

  # uppercase JIRA ticket
  jira=$(echo "$jira" | tr '[:lower:]' '[:upper:]')
  # if jira start with a number, add a JIRA_PROJECT
  if [[ "$jira" =~ ^[0-9] ]]; then
    jira="$JIRA_PROJECT-$jira"
  fi

  local title_branch_name=
  # lowercase title and replace non-alphanumeric characters with a dash
  title_branch_name=$(echo "$title" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g' | sed 's/[^a-zA-Z-]//g')

  local branch_name="$GH_SLUG/$jira-$title_branch_name"
  git checkout -B "$branch_name"

  yarn run changelog-add --description "$title" --jira-issue "$jira"

  git add .
  git commit -m "[$jira] $title"
  git push

  gh pr create --assignee @me --body " " --title "[$jira] $title" --web
}