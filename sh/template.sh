#!/bin/bash
# Starting template for shell scripts.
set -e

# ANSI Colors
GRAY_R='\033[0;90m'
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

# Colored prints
echo_grayr() {
  echo -e "${GRAY_R}$1${NC}"
}

echo_yellowr() {
  echo -e "${YELLOW_R}$1${NC}"
}

echo_purpler() {
  echo -e "${PURPLE_R}$1${NC}"
}

echo_greenr() {
  echo -e "${GREEN_R}$1${NC}"
}

echo_redr() {
  echo -e "${RED_R}$1${NC}" >&2
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

function print_usage() {
  echo "Usage: $0 <command> [options]"
  echo ""
  echo "Commands:"
  echo "  hello-name <name>   Print a personalized greeting"
  echo "  hello-world         Print a generic greeting"
  echo ""
  echo "Options:"
  echo "  --dry-run           Run the script in dry-run mode"
}

function hello_world() {
  echo_purpler "Hello world!"
}

function hello_name() {
  echo_purpler "Hello $1"
}

COMMAND=$1
shift 1
case $COMMAND in
"hello-name")
  hello_name "$@"
  ;;
"hello-world")
  hello_world
  ;;
*)
  echo_redr "Unknown command: $COMMAND"
  print_usage
  ;;
esac
