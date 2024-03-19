#!/bin/bash
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color
colors=(30 31 32 33 34 35 36 37)


print_yellow_box() {
    local width=${#1}
    local line=$(printf "%-${width}s" " ")
    echo -e "${YELLOW}╔${line// /═}══╗"
    echo -e "║ $1 ║"
    echo -e "╚${line// /═}══╝${NC}"
}

# Retrieve system information
. /etc/os-release /usr/lib/os-release
HOSTNAME=$(cat /etc/hostname)
SHELL=$(basename "$SHELL")
WM=$XDG_CURRENT_DESKTOP
up=$(uptime | grep -ohe 'up .*' | sed 's/,//g' | awk '{print $2, $3}')
cpu=$(grep 'model name' /proc/cpuinfo | uniq | awk -F ': ' '{print $2}')
mem_total=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_free=$(grep MemFree /proc/meminfo | awk '{print $2}')
mem_used=$((mem_total - mem_free))
for i in '/var/db/kiss/installed/*'  '/var/lib/pacman/local/[0-9a-z]*' \
'/var/lib/dpkg/info/*.list'  '/var/db/xbps/.*'  '/var/db/pkg/*/*'; do
	set -- $i
	[ $# -gt 1 ] && pkgs=$# && break
done
pkg_mgr=""
if command -v apk &>/dev/null; then
    pkg_mgr="apk"
elif command -v pacman &>/dev/null; then
    pkg_mgr="pacman"
elif command -v apt &>/dev/null; then
    pkg_mgr="apt"
elif command -v dnf &>/dev/null; then
    pkg_mgr="dnf"
elif command -v xbps-install &>/dev/null; then
    pkg_mgr="xbps"
else
    pkg_mgr="Unknown"
fi

print_yellow_box "System Information"
echo -e "${YELLOW}$(whoami)${NC}@$(cat /etc/hostname)"
echo -e "${BLUE}os ${NC}- $ID"
echo -e "${BLUE}sh ${NC}- $(basename "$SHELL")"
echo -e "${BLUE}term ${NC}- $TERM"
echo -e "${BLUE}wm ${NC}- $XDG_CURRENT_DESKTOP"
echo -e "${BLUE}up ${NC}- $up"
echo -e "${BLUE}cpu ${NC}- $cpu"
echo -e "${BLUE}mem ${NC}- $mem_used/$mem_total"
echo -e "${BLUE}kern ${NC}- $(uname -r)"
echo -e "${BLUE}pkgs ${NC}- $pkgs($pkg_mgr)"
echo ""
for color in "${colors[@]}"; do
	    printf "\033[0;${color}m██\033[0m"
done
printf "\n"
