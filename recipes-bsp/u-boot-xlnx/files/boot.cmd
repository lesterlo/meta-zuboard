# Set I2C bus to 0
i2c dev 0

# Read 6 bytes from EEPROM starting at offset 0x30
i2c read 0x51 0x30 0 6 ${scriptaddr}

# Convert the binary data to a MAC address string
setexpr ethaddr fmt "%02x:%02x:%02x:%02x:%02x:%02x" \
    ${scriptaddr:0} ${scriptaddr:1} ${scriptaddr:2} \
    ${scriptaddr:3} ${scriptaddr:4} ${scriptaddr:5}

# Save the environment
saveenv