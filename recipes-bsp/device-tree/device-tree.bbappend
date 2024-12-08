FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

EXTRA_OVERLAYS:append:zub = " enable_rspmsg.dtsi"
# EXTRA_DT_INCLUDE_FILES:append:zub = " enable_rspmsg.dtsi"

# do_configure:append() {
#    # Ensure the openamp dtsi is included in the device tree
#    if [ -f ${S}/arch/arm/boot/dts/zub.dts ]; then
#        echo '#include "openamp.dtsi"' >> ${S}/arch/arm/boot/dts/zub.dts
#    else
#        bbwarn "zub.dts not found! Please ensure the path is correct."
#    fi
# }