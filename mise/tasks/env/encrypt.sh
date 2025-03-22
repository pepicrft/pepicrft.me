#!/usr/bin/env bash
# mise description="Encrypts the .env file"

set -eo pipefail

sops encrypt -i --age "age1f4uuqnszd0txrz8lnfsv0r6vl2xnt7gfe09yvpgermqn09ksdpvsnllkp8" .env.json
