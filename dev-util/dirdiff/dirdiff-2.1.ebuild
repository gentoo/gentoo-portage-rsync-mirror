# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dirdiff/dirdiff-2.1.ebuild,v 1.4 2009/10/12 20:31:30 ssuominen Exp $

DESCRIPTION="A tool for differing and merging directories"
SRC_URI="http://samba.org/ftp/paulus/${P}.tar.gz"
HOMEPAGE="http://samba.org/ftp/paulus/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/tk
		dev-lang/tcl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:CFLAGS=-O3 \(.*\):CFLAGS=${CFLAGS} -fPIC \1:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin dirdiff || die
	dolib.so libfilecmp.so.0.0 || die
	dodoc README
}
