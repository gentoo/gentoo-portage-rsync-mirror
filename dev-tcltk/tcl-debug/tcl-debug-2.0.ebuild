# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcl-debug/tcl-debug-2.0.ebuild,v 1.6 2005/07/19 14:05:28 dholm Exp $

DESCRIPTION="TCL debug library"
HOMEPAGE="http://expect.nist.gov"
SRC_URI="http://expect.nist.gov/tcl-debug/${PN}.tar.gz
		 doc? ( http://expect.nist.gov/tcl-debug/tcl-debug.ps.Z )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="doc"
DEPEND=">=dev-lang/tcl-8.3.0
		>=dev-lang/tk-8.3.0"

src_compile() {
	econf \
		--enable-shared \
		--with-tcl=/usr/lib \
		--with-tclinclude="`ls /usr/lib/tcl8.*/include/generic/tclInt.h | tail -n1 | xargs dirname`" || die "./configure failed"
	emake || die
}

src_install() {
	dolib.so libtcldbg2.0.so
	dolib.a libtcldbg.a
	dodir /usr/lib/tcldbg${PV}
	dosym /usr/lib/libtcldbg2.0.so /usr/lib/tcldbg${PV}/
	dosym /usr/lib/libtcldbg.a /usr/lib/tcldbg${PV}/

	insinto /usr/lib/tcldbg${PV}
	newins pkgIndex pkgIndex.tcl

	dodir /usr/include
	insinto /usr/include
	doins tcldbg.h

	dodoc HISTORY README CHANGES INSTALL
	newman tcldbg.man tcldbg.1
}
