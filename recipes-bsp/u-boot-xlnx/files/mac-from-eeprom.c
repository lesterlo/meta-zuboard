#include <common.h>
#include <i2c.h>
#include <env.h>
#include <asm/io.h>

#define EEPROM_I2C_BUS 0        /* I2C bus number */
#define EEPROM_ADDR    0x58     /* EEPROM I2C address */
#define MAC_REG_ADDR   0x9A     /* Register address for MAC */
#define MAC_LEN        6        /* MAC address length */

/* Function to read MAC from EEPROM and set as ethaddr */
int read_mac_from_eeprom(void) {
    uint8_t mac[MAC_LEN];
    struct udevice *dev;
    int ret;

    /* Initialize I2C */
    ret = i2c_get_chip_for_busnum(EEPROM_I2C_BUS, EEPROM_ADDR, 1, &dev);
    if (ret) {
        printf("Error: Failed to initialize I2C device (bus: %d, addr: 0x%x)\n",
               EEPROM_I2C_BUS, EEPROM_ADDR);
        return -1;
    }

    /* Read MAC address from EEPROM */
    ret = dm_i2c_read(dev, MAC_REG_ADDR, mac, MAC_LEN);
    if (ret) {
        printf("Error: Failed to read MAC address from EEPROM\n");
        return -1;
    }

    /* Set ethaddr environment variable */
    char mac_str[18];
    sprintf(mac_str, "%02x:%02x:%02x:%02x:%02x:%02x",
            mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
    env_set("ethaddr", mac_str);

    printf("MAC address set to: %s\n", mac_str);
    return 0;
}

/* Hook into U-Boot */
int board_late_init(void) {
    return read_mac_from_eeprom();
}
