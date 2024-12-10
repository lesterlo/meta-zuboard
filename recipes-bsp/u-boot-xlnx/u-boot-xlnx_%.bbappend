FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://modify_feature.cfg"
SRC_URI += "file://eth_mac_overlay.dts"
# SRC_URI += "file://boot.cmd"

# DEPENDS += "u-boot-mkimage-native"

do_compile:append() {
    # Compile the device tree overlay
    dtc -I dts -O dtb -o ${WORKDIR}/eth_mac_overlay.dtbo ${WORKDIR}/eth_mac_overlay.dts

    # Copy the overlay to the U-Boot device tree source folder
    cp ${WORKDIR}/eth_mac_overlay.dtbo ${S}/arch/arm/dts/
}

# do_install:append() {
#     # Install boot.scr into the boot directory
#     install -d "${D}/boot"
#     install -m 0644 "${WORKDIR}/boot.scr" "${D}/boot/"
# }