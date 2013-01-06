# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/connect/connect-100.ebuild,v 1.5 2012/10/08 11:08:10 nativemad Exp $

inherit toolchain-funcs

IUSE=""
DESCRIPTION="network connection relaying command"
HOMEPAGE="http://www.meadowy.org/~gotoh/projects/connect/"
SRC_URI="http://www.meadowy.org/~gotoh/ssh/${PN}-r${PV}.c"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
DEPEND=""
S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}/${A}" "${S}/"
}

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o ${PN} ${PN}-r${PV}.c || die "compiler failed"
}

src_install() {
	dobin ${PN}
}

pkg_postinst() {
	einfo
	einfo "There is no manpage, please see ${HOMEPAGE} for details"
	einfo
}
