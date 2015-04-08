# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rescan-scsi-bus/rescan-scsi-bus-1.25.ebuild,v 1.8 2012/02/25 06:24:37 robbat2 Exp $

DESCRIPTION="Script to rescan the SCSI bus without rebooting"
HOMEPAGE="http://www.garloff.de/kurt/linux/"
SCRIPT_NAME="${PN}.sh"
SRC_URI="http://www.garloff.de/kurt/linux/${SCRIPT_NAME}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/sg3_utils-1.24
		 virtual/modutils
		 app-shells/bash"

S="${WORKDIR}"

src_unpack() {
	cp -f "${DISTDIR}"/${A} "${WORKDIR}"/${SCRIPT_NAME}
}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {
	into /usr
	dosbin ${SCRIPT_NAME}
	dosym ${SCRIPT_NAME} /usr/sbin/${PN}
}
