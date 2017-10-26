#!/usr/bin/env bash
set -e

echo "Running simulation for 5s"
timeout 5s run_avr --mcu atmega328p --freq 16000000 /input/LedToggle-atmega328p.elf
