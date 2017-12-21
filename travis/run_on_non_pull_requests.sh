#!/bin/bash -xe

# OLD: openssl aes-256-cbc -K $encrypted_04d890b7acfa_key -iv $encrypted_04d890b7acfa_iv -in deploy-key.enc -out deploy-key -d
openssl aes-256-cbc -K $encrypted_0c6e7fea9ec7_key -iv $encrypted_0c6e7fea9ec7_iv -in deploy-key.enc -out deploy-key -d
chmod 600 deploy-key
eval `ssh-agent -s`
ssh-add deploy-key
git config user.name "Automatic Publish"
git config user.email "goc@opensciencegrid.org"
git remote add gh-token "${GH_REF}";
git fetch gh-token && git fetch gh-token gh-pages:gh-pages
echo "Pushing to GitHub"
PYTHONPATH=src/ mkdocs gh-deploy -v --clean --remote-name gh-token
git push gh-token gh-pages
