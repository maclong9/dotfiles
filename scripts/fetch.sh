BLUE='\033[0;34m'
NC='\033[0m'

# Operating System
. /etc/os-release /usr/lib/os-release

# Uptime
IFS=. read -r uptime _ < /proc/uptime
d=$((uptime / 60 / 60 / 24))
up=$(printf %02d:%02d $((uptime / 60 / 60 % 24)) $((uptime / 60 % 60)))
[ "$d" -gt 0 ] && up="${d}d $up"

# Processor
while read -r line; do
	case $line in 
		vendor_id*) vendor="${line##*: } ";;
		model\ name*) cpu=${line##*: }; break;;
	esac
done < /proc/cpuinfo

read -r _ _ version _ < /proc/version
kernel=${version%%-*}

for i in '/var/db/kiss/installed/*'  '/var/lib/pacman/local/[0-9a-z]*' \
'/var/lib/dpkg/info/*.list'  '/var/db/xbps/.*'  '/var/db/pkg/*/*'; do
	set -- $i
	[ $# -gt 1 ] && pkgs=$# && break
done

echo "$USER@$(cat /etc/hostname)"
echo "${BLUE}os ${NC}~ $ID"
echo "${BLUE}sh ${NC}~ $(basename $SHELL)"
echo "${BLUE}term ${NC}~ $TERM"
echo "${BLUE}wm ${NC}~ $XDG_CURRENT_DESKTOP"
echo "${BLUE}up ${NC}~ $up"
echo "${BLUE}cpu ${NC}~ $cpu"
echo "${BLUE}mem ${NC}~ $((($(grep MemTotal /proc/meminfo | awk '{print $2}') - $(grep MemFree /proc/meminfo | awk '{print $2}'))))/$(grep MemTotal /proc/meminfo | awk '{print $2}')"
echo "${BLUE}kern ${NC}~ $kernel"
echo "${BLUE}pkgs ${NC}~ $pkgs()"
