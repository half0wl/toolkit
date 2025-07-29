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
