#!/bin/bash
set -eu
setaf=$(tput setaf)
set_fg_red=$(tput setaf 1)
set_fg_bright_red=$(tput setaf 9)
clear_attrs=$(tput sgr0)

declare -p setaf set_fg_red set_fg_bright_red clear_attrs
echo "${set_fg_red}hi ${set_fg_bright_red}there ${clear_attrs}again"
