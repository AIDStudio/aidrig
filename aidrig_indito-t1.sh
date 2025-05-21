#!/bin/bash

AIDRIG_PATH="./aidrig"
CPU=$(nproc)
AIDRIG_ARGS=" -a rx -o stratum+ssl://rx.unmineable.com:443 -u XMR:YOUR_WALLET.WORKER -t $CPU -p x -k"

SESSION_NAME="aidrig_miner"
LOG_FILE="./aidrig.log"

if [ ! -x "$AIDRIG_PATH" ]; then
  echo "Futtathatóvá tesszük az aidrig fájlt"
  chmod +x "$AIDRIG_PATH"
fi

while true; do
  if ! screen -list | grep -q "$SESSION_NAME"; then
    echo "$(date): Screen session nem fut, indítás: $SESSION_NAME"
    screen -dmS $SESSION_NAME bash -c "nice -n -10 $AIDRIG_PATH $AIDRIG_ARGS >> $LOG_FILE 2>&1"
  fi
  sleep 10
done