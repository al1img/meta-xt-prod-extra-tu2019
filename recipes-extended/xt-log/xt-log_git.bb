DESCRIPTION = "C++ header only log"
SECTION = "libs"
LICENSE = "GPLv3"

SRC_URI = "git://github.com/xen-troops/${PN}.git"
SRCREV = "${AUTOREV}"

LIC_FILES_CHKSUM = "file://LICENSE;md5=1ebbd3e34237af26da5dc08a4e440464"

S = "${WORKDIR}/git"

inherit pkgconfig cmake
