# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-backup/duply/duply-1.9.1.ebuild,v 1.1 2014/10/17 07:50:56 jlec Exp $

EAPI=5

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

src_install() {
	dobin ${PN}
	./${PN} txt2man > ${PN}.1 || die
	doman ${PN}.1
	readme.gentoo_create_doc
}
