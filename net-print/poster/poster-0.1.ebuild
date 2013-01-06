# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/poster/poster-0.1.ebuild,v 1.9 2009/12/15 18:02:56 ssuominen Exp $

inherit toolchain-funcs

S="${WORKDIR}/${PN}"
DESCRIPTION="small utility for making a poster from an EPS file or a one-page PS document"
SRC_URI="mirror://gentoo/poster.tgz"
HOMEPAGE="http://printing.kde.org/downloads"

LICENSE="poster"
KEYWORDS="~amd64 ppc x86"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	chmod u+rwx ./poster
	cd ${S}
	tar -zxf ./poster.tar.gz || die "tar failed"
}

src_compile(){
	`tc-getCC` ${CFLAGS} poster.c -lm -o ${PN} || die "compile failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman ${PN}.1 || die "dodoc failed"
}
