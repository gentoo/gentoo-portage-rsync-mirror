# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rescan-scsi-bus/rescan-scsi-bus-1.57-r1.ebuild,v 1.2 2014/07/01 13:11:03 jer Exp $

EAPI=5

inherit eutils

DESCRIPTION="Script to rescan the SCSI bus without rebooting"
HOMEPAGE="http://www.garloff.de/kurt/linux/"
SCRIPT_NAME="${PN}.sh"
SRC_NAME="${SCRIPT_NAME}-${PV}"
SRC_URI="http://www.garloff.de/kurt/linux/${SRC_NAME}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~x86" # alpha hppa ppc64 sparc

RDEPEND=">=sys-apps/sg3_utils-1.24
	app-admin/killproc
	virtual/modutils
	app-shells/bash"

S=${WORKDIR}

src_unpack() {
	cp -f "${DISTDIR}"/${SRC_NAME} "${WORKDIR}"/${SCRIPT_NAME}
}

src_install() {
	into /usr
	dosbin ${SCRIPT_NAME}
	# Some scripts look for this without the trailing .sh
	# Some look for it with the trailing .sh, so have a symlink
	dosym ${SCRIPT_NAME} /usr/sbin/${PN}
}
