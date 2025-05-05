#!/bin/bash
# Collection of various bash helper functions, utilities, and tips & tricks.
# https://github.com/half0wl/bash-toolkit
set -e

# ANSI colors
GREEN_R='\033[0;32m'
GREEN_B='\033[1;92m'
RED_R='\033[0;31m'
RED_B='\033[1;91m'
YELLOW_R='\033[0;33m'
YELLOW_B='\033[1;93m'
PURPLE_R='\033[0;35m'
PURPLE_B='\033[1;95m'
WHITE_R='\033[0;37m'
WHITE_B='\033[1;97m'
NC='\033[0m'

# is_dry_run() checks if the --dry-run flag is present in the arguments.
# Returns true if the flag is present, false otherwise.
#
# Usage:
#
#   DRY_RUN=$(is_dry_run "$@")
#   if [ "$DRY_RUN" = "true" ]; then
#       echo "dryrun"
#   else
#       echo "normal"
#   fi
is_dry_run() {
  local dry_run=false
  for arg in "$@"; do
    case $arg in
    --dry-run)
      dry_run=true
      break
      ;;
    esac
  done
  echo "$dry_run"
}

# confirm() shows a prompt to the user and returns true if the user types
# 'y' or 'Y'. Returns false otherwise.
#
# Usage:
#
#   if confirm "Continue?"; then
#     # yes
#   else
#    # no
#    exit 1
#   fi
confirm() {
  local prompt="$1"
  local default="$2"
  default=${default:-"N"}
  if [ "$default" = "Y" ]; then
    echo ""
    prompt="$prompt [Y/n]: "
    echo ""
  else
    echo ""
    prompt="$prompt [y/N]: "
    echo ""
  fi
  read -r -p "$prompt" response
  if [ -z "$response" ]; then
    response=$default
  fi
  if [[ "$response" =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}
