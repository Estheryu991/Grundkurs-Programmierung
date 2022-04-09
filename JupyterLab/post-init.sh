#!/bin/bash

mkdir -p /home/jovyan/work/.jupyter_config/lab/user-settings/@jupyterlab/toc-extension
cp ./.user-settings/@jupyterlab/toc-extension/plugin.jupyterlab-settings /home/jovyan/work/.jupyter_config/lab/user-settings/@jupyterlab/toc-extension/plugin.jupyterlab-settings

# sync latest changes from upstream fork
# TODO: maybe we'll switch this to main in the future
REMOTE_BRANCH="master"

# get current semester
SEMESTER=$(git remote get-url origin | sed -re 's/https\:\/\/renkulab\.io\/gitlab\/.+\/(.*)\.git/\1/gi')

# add upstream remote
git remote add upstream https://renkulab.io/gitlab/grundkurs-programmieren/${SEMESTER}.git

# make sure we're in master branch
git checkout ${REMOTE_BRANCH}

# fetch and pull changes
while true; do
    git fetch upstream
    if [ $? -eq 0 ]; then
        git pull upstream ${REMOTE_BRANCH}
        break
    fi
done

# sync back to origin
git push origin ${REMOTE_BRANCH}
