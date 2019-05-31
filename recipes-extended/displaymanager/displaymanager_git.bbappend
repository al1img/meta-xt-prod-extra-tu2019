FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRCREV = "${AUTOREV}"

SRC_URI_append = " \
    git://github.com/xen-troops/DisplayManager.git;protocol=https;branch=tu2019-demo \
    file://display_manager.conf \
    file://display-manager.service \
    file://dm.cfg \
"

DEPENDS = "libconfig wayland-ivi-extension dbus-cxx git-native xt-log"

EXTRA_OECMAKE_append = " -DWITH_DOC=OFF -DCMAKE_BUILD_TYPE=Release"

inherit systemd

SYSTEMD_SERVICE_${PN} = "display-manager.service"

do_install_append() {
    install -d ${D}${sysconfdir}/dbus-1/session.d
    install -m 0755 ${WORKDIR}/display_manager.conf ${D}${sysconfdir}/dbus-1/session.d/

    install -d ${D}${base_prefix}/xt/cfg
    install -m 0744 ${WORKDIR}/dm.cfg ${D}${base_prefix}/xt/cfg/dm.cfg

    install -d  ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/display-manager.service ${D}${systemd_unitdir}/system/
}

FILES_${PN} += " \
    ${sysconfdir}/dbus-1/session.d/display_manager.conf \
    ${base_prefix}/xt/cfg/*.cfg \
    ${systemd_unitdir}/display-manager.service \
"
