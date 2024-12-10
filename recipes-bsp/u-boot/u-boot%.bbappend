FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

do_install_append() {
    install -d ${D}/boot
    install -m 0755 ${WORKDIR}/read_mac_eeprom.scr ${D}/boot/
}

do_compile_append() {
    mkimage -A arm -T script -C none -n "EEPROM MAC Script" \
        -d ${WORKDIR}/read_mac_eeprom.txt ${WORKDIR}/read_mac_eeprom.scr
}

# Optionally, set the default boot script to use this script
# EXTRA_OEMAKE += "DEFAULT_SCRIPT=boot.scr"