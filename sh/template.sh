#!/bin/bash
# ========================================================================== #
# https://github.com/half0wl/toolkit                                         #
# MIT License - (c) 2025 Ray Chen <meow@ray.cat>                             #
#                                                                            #
# template.sh - A starting template for shell scripts.                       #
# ========================================================================== #
set -eou pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib.sh"

function print_usage() {
  echo "Usage: $0 <command> [options]"
  echo ""
  echo "Commands:"
  echo "  help                   Print usage information"
  echo "  usage                  Print usage information"
  echo "  hello-name <name>      Print a personalized greeting"
  echo "  hello-world            Print a generic greeting"
  echo "  print-sample-messages  Print sample messages"
  echo ""
  echo "Options:"
  echo "  --dry-run              Run the script in dry-run mode"
}

function hello_world() {
  write_info "Hello world!"
}

function hello_name() {
  local name="${1:-World}"
  write_info "Hello $name"
}

function print_sample_messages() {
  write_busy "Printing samples messages"
  sleep 1
  write_done "This is a sample done message"
  write_info "This is an informational message"
  sleep 0.5
  write_success "This is a successful message"
  sleep 0.5
  write_warning "This is a warning message"
  sleep 0.5
  write_error "This is an error message"
  sleep 0.5
}

if [ $# -eq 0 ]; then
  print_usage
  exit 0
fi

COMMAND=$1
shift 1

case $COMMAND in
"help")
  print_usage
  ;;
"usage")
  print_usage
  ;;
"hello-name")
  hello_name "$@"
  ;;
"hello-world")
  hello_world
  ;;
"print-sample-messages")
  print_sample_messages
  ;;
*)
  write_error "Unknown command: $COMMAND"
  print_usage
  exit 1
  ;;
esac
