#!/usr/bin/env bash
# mise description="Installs the project dependencies"

mix deps.get
vale sync
