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
