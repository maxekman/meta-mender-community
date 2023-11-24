EXTRADEPS = ""
EXTRADEPS:tegra = "tegra-bup-payload tegra-boot-tools tegra-boot-tools-nvbootctrl tegra-boot-tools-lateboot${@' libubootenv-fake' if d.getVar('PREFERRED_PROVIDER_virtual/bootloader').startswith('cboot') else ''}"
EXTRADEPS:tegra210 = "tegra-bup-payload tegra-boot-tools"
EXTRADEPS:tegra194 = "tegra-bup-payload libubootenv-fake mender-update-verifier"
EXTRADEPS:tegra234 = "tegra-bup-payload libubootenv-fake mender-update-verifier"
RDEPENDS:${PN} += "${EXTRADEPS}"

FILESEXTRAPATHS:prepend:tegra234 := "${THISDIR}/files/tegra234:"
FILESEXTRAPATHS:prepend:tegra194 := "${THISDIR}/files/tegra194:"

SRC_URI:remove:mender-persist-systemd-machine-id = " \
    file://mender-client-set-systemd-machine-id.sh \
"
SRC_URI:append:tegra234:mender-persist-systemd-machine-id = " \
    file://tegra234-mender-client-set-systemd-machine-id.sh \
    file://efi_systemd_machine_id.sh \
"
SRC_URI:append:tegra194:mender-persist-systemd-machine-id = " \
    file://tegra194-mender-client-set-systemd-machine-id.sh \
    file://efi_systemd_machine_id.sh \
"

do_install:prepend:tegra234:class-target:mender-persist-systemd-machine-id() {
    install -d -m 755 ${D}${bindir}
    install -m 755 ${WORKDIR}/efi_systemd_machine_id.sh ${D}${bindir}/
    cp ${WORKDIR}/tegra234-mender-client-set-systemd-machine-id.sh ${WORKDIR}/mender-client-set-systemd-machine-id.sh 
}
do_install:prepend:tegra194:class-target:mender-persist-systemd-machine-id() {
    install -d -m 755 ${D}${bindir}
    install -m 755 ${WORKDIR}/efi_systemd_machine_id.sh ${D}${bindir}/
    cp ${WORKDIR}/tegra194-mender-client-set-systemd-machine-id.sh ${WORKDIR}/mender-client-set-systemd-machine-id.sh 
}
