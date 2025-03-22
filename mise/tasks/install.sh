#!/usr/bin/env bash
# mise description="Installs the project dependencies"

(cd $MISE_PROJECT_ROOT && bundle install)
(cd $MISE_PROJECT_ROOT && mix deps.get)
(cd $MISE_PROJECT_ROOT && vale sync)
