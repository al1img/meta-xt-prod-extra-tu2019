FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = "\
    file://aos-vis_telemetryemulator.service \
    file://aos-vis_renesassimulator.service \
    file://visconfig_telemetryemulator.json \
    file://visconfig_renesassimulator.json \
"

PLUGINS += "\
    storageadapter \
    renesassimulatoradapter \
"

inherit systemd

SYSTEMD_SERVICE_${PN} = "aos-vis.service"

HOST_CC_ARCH = ""

FILES_${PN} += " \
    ${systemd_system_unitdir}/aos-vis.service \
    /var/aos/vis/data/*.pem \
    /var/aos/vis/visconfig.json \
"

RDEPENDS_${PN} += "\
    ${@bb.utils.contains('PLUGINS', 'telemetryemulatoradapter', 'telemetry-emulator', '', d)} \
"

do_install_append() {
    install -d ${D}/var/aos/vis
    install -d ${D}${systemd_system_unitdir}

    if "${@bb.utils.contains('PLUGINS', 'telemetryemulatoradapter', 'true', 'false', d)}";then
        install -m 0644 ${WORKDIR}/visconfig_telemetryemulator.json ${D}/var/aos/vis/visconfig.json
        install -m 0644 ${WORKDIR}/aos-vis_telemetryemulator.service ${D}${systemd_system_unitdir}/aos-vis.service
    fi

    if "${@bb.utils.contains('PLUGINS', 'renesassimulatoradapter', 'true', 'false', d)}";then
        install -m 0644 ${WORKDIR}/visconfig_renesassimulator.json ${D}/var/aos/vis/visconfig.json
        install -m 0644 ${WORKDIR}/aos-vis_renesassimulator.service ${D}${systemd_system_unitdir}/aos-vis.service
    fi

    install -d ${D}/var/aos/vis/data
    install -m 0644 ${S}/src/${GO_IMPORT}/data/*.pem ${D}/var/aos/vis/data
}
