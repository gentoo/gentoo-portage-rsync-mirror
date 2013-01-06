# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dirdiff/dirdiff-2.1-r1.ebuild,v 1.4 2012/05/29 19:29:19 ranger Exp $

EAPI="2"

inherit eutils toolchain-funcs

DESCRIPTION="A tool for differing and merging directories"
SRC_URI="http://samba.org/ftp/paulus/${P}.tar.gz"
HOMEPAGE="http://samba.org/ftp/paulus/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/tk
		dev-lang/tcl"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-include.patch
	sed -i Makefile -e 's|=-O3|+=|g' || die "sed Makefile"
}

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS} -fPIC ${LDFLAGS} -Wl,-soname,libfilecmp.so.0" \
		|| die
}

src_install() {
	dobin dirdiff || die
	dolib.so libfilecmp.so.0.0 || die
	dodoc README
}
