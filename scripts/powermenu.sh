#!/usr/bin/env bash

set -u

if ! command -v wofi >/dev/null 2>&1; then
    notify-send "Power Menu" "Wofi is not installed."
    exit 1
fi

menu() {
    printf '%s\n' \
        "  Lock" \
        "  Suspend" \
        "  Reboot" \
        "  Shutdown" \
        "󰍃  Logout"
}

confirm() {
    local action="$1"
    local answer

    answer=$(
        printf '%s\n' "Confirm" "Cancel" |
            wofi --show dmenu \
                --prompt "Confirm ${action}?" \
                --cache-file /dev/null
    ) || return 1

    [[ "$answer" == "Confirm" ]]
}

choice=$(menu | wofi --show dmenu \
    --prompt "Power Menu" \
    --cache-file /dev/null) || exit 0

case "$choice" in
    *Lock)
        if command -v swaylock >/dev/null 2>&1; then
            swaylock -f
        else
            notify-send "Power Menu" "Install swaylock to lock the screen."
        fi
        ;;

    *Suspend)
        systemctl suspend
        ;;

    *Reboot)
        if confirm "Reboot"; then
            systemctl reboot
        fi
        ;;

    *Shutdown)
        if confirm "Shutdown"; then
            systemctl poweroff
        fi
        ;;

    *Logout)
        if confirm "Logout"; then
            niri msg action quit
        fi
        ;;
esac