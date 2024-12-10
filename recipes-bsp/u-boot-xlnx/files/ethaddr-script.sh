#!/bin/bash

# Read MAC address from EEPROM using I2C
i2c_dev=1         # I2C bus number (usually 1 on most systems)
eeprom_addr=0x58  # I2C EEPROM address
register_addr=0x9a # Register address to read the MAC address from

# Use U-Boot's I2C read command to get the MAC address
mac_data=$(i2c dev $i2c_dev; i2c mw $eeprom_addr $register_addr 6)

# Parse the MAC address (assumes it's returned in hex format)
mac_addr=$(echo $mac_data | cut -d ' ' -f 2-7)

# Set the ethaddr in U-Boot
setenv ethaddr $mac_addr

# Optionally, you can print out the MAC address to verify
echo "MAC address read from EEPROM: $mac_addr"