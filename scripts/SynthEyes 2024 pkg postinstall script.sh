#!/bin/bash

# These folders are required for holding RLM licensing information

if ! [ -a "/Library/Application Support/GenArts" ]; then
  mkdir "/Library/Application Support/GenArts"
  chmod 777 "/Library/Application Support/GenArts"
  chown root:admin "/Library/Application Support/GenArts"
fi
if ! [ -a "/Library/Application Support/GenArts/rlm" ]; then
  mkdir "/Library/Application Support/GenArts/rlm"
  chmod 777 "/Library/Application Support/GenArts/rlm"
  chown root:admin "/Library/Application Support/GenArts/rlm"
fi
if ! [ -a "/Library/Application Support/Reprise" ]; then
  mkdir "/Library/Application Support/Reprise"
  chmod 777 "/Library/Application Support/Reprise"
  chown root:admin "/Library/Application Support/Reprise"
fi

