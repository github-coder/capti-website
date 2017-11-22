#!/bin/bash

set -e # exit with nonzero exit code if anything fails

if [[ $TRAVIS_BRANCH == "master" && $TRAVIS_PULL_REQUEST == "false" ]]; then

echo "Starting to update gh-pages"

#copy data we're interested in to other place
cp -R docs $HOME/docs

#go to home and setup git
cd $HOME
git config --global user.email "sdhnik@gmail.com"
git config --global user.name "sdhnik"

#using token clone gh-pages branch
git clone --quiet --branch=gh-pages https://github.com/github-coder/capti-website.git gh-pages > /dev/null

#go into directory and copy data we're interested in to that directory
cd gh-pages
cp -Rf $HOME/docs/* .

#add, commit and push files
git add -f .
git commit -m "Travis build $TRAVIS_BUILD_NUMBER"
git push -fq origin gh-pages > /dev/null

echo "Done updating gh-pages"

else
 echo "Skipped updating gh-pages, because build is not triggered from the master branch."
fi;