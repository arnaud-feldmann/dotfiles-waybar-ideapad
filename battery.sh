#!/bin/bash

CHARGING_ICON=""
SAVE_MODE_ICON=""
SAVE_MODE_STOP_ICON="󱈑"
BAT_ICONS=("" "" "" "" "")
BAT="/sys/class/power_supply/BAT1"

BAT_CAP=$(cat $BAT/capacity)
BAT_STA=$(cat $BAT/status)
SAV_MOD=$(cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode)

ACTIVE_SAV_ICON=$([ $SAV_MOD = 1 ] && echo "$SAVE_MODE_ICON";)
ACTIVE_BAT_ICON=$( \
	{ [ "$BAT_STA" = "Charging" ] && echo $CHARGING_ICON; } || \
	{ [ $SAV_MOD = 1 ] && [ "$BAT_STA" = "Not charging" ] && echo $SAVE_MODE_STOP_ICON; } || \
	echo ${BAT_ICONS[$(($BAT_CAP*${#BAT_ICONS[@]}/100))]}
)
ACTIVE_TEXT=$(echo "${BAT_CAP}%")

printf "%s  %s %s" $ACTIVE_SAV_ICON $ACTIVE_TEXT $ACTIVE_BAT_ICON

