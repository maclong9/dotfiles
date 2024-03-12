battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
battery_status=$(cat /sys/class/power_supply/BAT0/status)
battery_icon=""
current_date=$(date +"%A, %d %B %H %M")

if [ $battery_status = "Discharging" ]; then
  if [ $battery_level -le 10 ]; then
      battery_icon="󰁺"
  elif [ $battery_level -le 20 ]; then
      battery_icon="󰁻"
  elif [ $battery_level -le 30 ]; then
      battery_icon="󰁼"
  elif [ $battery_level -le 40 ]; then
      battery_icon="󰁽"
  elif [ $battery_level -le 50 ]; then
      battery_icon="󰁾"
  elif [ $battery_level -le 60 ]; then
      battery_icon="󰁾"
  elif [ $battery_level -le 70 ]; then
      battery_icon="󰁿"
  elif [ $battery_level -le 80 ]; then
      battery_icon="󰂀"
  elif [ $battery_level -le 90 ]; then
      battery_icon="󰂁"
  elif [ $battery_level -le 100]; then
      battery_icon="󰂂"
  else  
      battery_icon="󰁹"
  fi
else
    battery_icon="󰂄"
fi

echo "$battery_icon$battery_level%  $current_date"
