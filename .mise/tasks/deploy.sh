#!/usr/bin/env bash
# mise description="Deploys the website using Kamal"

(cd $MISE_PROJECT_ROOT && bundle exec kamal deploy)
