# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xearth/xearth-1.1.ebuild,v 1.15 2012/03/18 19:57:14 armin76 Exp $

HOMEPAGE="http://hewgill.com/xearth/original/"
DESCRIPTION="Xearth sets the X root window to an image of the Earth"
SRC_URI="ftp://cag.lcs.mit.edu/pub/tuna/${P}.tar.gz
	ftp://ftp.cs.colorado.edu/users/tuna/${P}.tar.gz"

SLOT="0"
LICENSE="xearth"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-misc/imake
	app-text/rman
	x11-proto/xproto"

src_compile() {
	xmkmf || die
	mv Makefile Makefile.orig
	sed -e "s:CDEBUGFLAGS = .*:CDEBUGFLAGS = ${CFLAGS} -fno-strength-reduce:" \
			Makefile.orig > Makefile
	emake || die
}

src_install() {
	newman xearth.man xearth.1
	dobin xearth
	dodoc BUILT-IN GAMMA-TEST HISTORY README
}
