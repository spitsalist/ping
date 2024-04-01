#!/bin/bash
#

ping_address() {
  local address="$1"
  local ping_result=$(ping -c 3 -i 1 -W 1 "$address" 2>&1)

  # Check if ping was successful (exit code 0)
  if [[ $? -eq 0 ]]; then
    local avg_ping=$(echo "$ping_result" | awk -F '/' '{print $5}')

    # Check for valid average using bc (check for errors from bc)
    if [[ $(echo "$avg_ping > 100" | bc 2>/dev/null) -eq 0 ]]; then
      echo "Среднее время для $address превышает 100 мс: $avg_ping мс"
    fi
  else
    echo "Пинг не удался для $address"
  fi
}

while true; do
  ping_address "google.com"
  sleep 1
done


