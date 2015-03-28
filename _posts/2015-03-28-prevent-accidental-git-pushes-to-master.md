---
title: Preventing accidental pushes to master
tags:
  - git
  - hooks
  - flow
---

Git hooks are scripts that can be ran either on the server side or on the client side, to allow or block any git action. Hooks can help you protect the code base by enforcing rules.

Our team is using gitlab, and our master branch is protected, so only masters, owners, or admins can push to it, after changes are tested and reviewed. However, as an admin, I recently accidentally pushed some things I wanted reviewed to the master branch. To avoid this, I took advantage of the pre-push hook, which, as you might guess, is ran before pushes, to ask for a confirmation when I try to push to master. Here is the script I added to each of my projects, in `.git/hooks/pre-push`:

    #!/bin/sh
    # This hook tries to prevent accidental pushes to the master
    # branch by asking for confirmation before doing it.

    branch=`git rev-parse --abbrev-ref HEAD`

    exec < /dev/tty
    while true; do
        if [ "$branch" = "master" ]; then
            read -p "Are you sure you want to push to the master branch? (y/n) " yn
            if [ "$yn" = "" ]; then
                $yn='N'
            fi
            case $yn in
                [Yy] ) echo "Ok, pushing."; exit 0;;
                [Nn] ) echo "Cancelling push"; exit 1;;
                * ) echo "Please answer y or n for yes or no";;
            esac
        else
            break;
        fi
    done
    exit 0

Chmod it to +x to allow execution, and you're done.
