# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/duply/duply-1.7.4.ebuild,v 1.1 2014/06/27 13:35:39 jlec Exp $

EAPI="5"

inherit readme.gentoo

DESCRIPTION="A shell frontend for duplicity"
HOMEPAGE="http://duply.net"
SRC_URI="mirror://sourceforge/ftplicity/${PN}_${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/txt2man"
RDEPEND="app-backup/duplicity"

S=${WORKDIR}/${PN}_${PV}

DOC_CONTENTS="
If you use ${PN} at the first time please have a
look at the the usage help text \"${PN} usage\"
for further information."

src_install() {
	dobin ${PN}
	./${PN} txt2man > ${PN}.1
	doman ${PN}.1
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
