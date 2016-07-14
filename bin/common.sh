# Common settings & constants.

if [[ -z "${color_start-}" ]]; then
  declare -r color_start="\033["
  declare -r color_red="${color_start}0;31m"
  declare -r color_yellow="${color_start}0;33m"
  declare -r color_green="${color_start}0;32m"
  declare -r color_norm="${color_start}0m"
fi

# Print colored text.
cprint () {
    local text=$1
    local color=$2
    echo -e "${color}$text${color_norm}"
}

# Print stuff in yellow.
yellowprint () {
  local text=$1
  cprint "$text" ${color_yellow}
}

redprint () {
  local text=$1
  cprint "$text" ${color_red}
}

greenprint () {
  local text=$1
  cprint "$text" ${color_green}
}
