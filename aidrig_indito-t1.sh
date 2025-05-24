#!/bin/bash

AIDRIG_PATH="./aidrig"
CPU="2"
AIDRIG_ARGS=" -a rx -o stratum+ssl://rx.unmineable.com:443 -u POL:YOUR_WALLET.CPU2 -t $CPU -p x -k"

SESSION_NAME="aidrig_miner"
LOG_FILE="./aidrig.log"

if [ ! -x "$AIDRIG_PATH" ]; then
  echo "Futta thatóvá tesszük az aidrig fájlt"
  chmod +x "$AIDRIG_PATH"
fi

while true; do
  if ! screen -list | grep -q "$SESSION_NAME"; then
    echo "$(date): Screen session nem fut, indítás: $SESSION_NAME"
    screen -dmS $SESSION_NAME bash -c "nice -n -10 $AIDRIG_PATH $AIDRIG_ARGS >> $LOG_FILE 2>&1"
  fi
  sleep 10
done

# sudo sysctl -w vm.nr_hugepages=1280
#
# sudo apt update && sudo apt upgrade
#
# sudo apt install libhwloc-dev
#
# sudo apt install libuv1-dev

# ./aidrig -a randomx -o us.mining.prohashing.com:3359 -u aidmine -p a=randomx,n=Ody_CodeSpace,o=aidmining