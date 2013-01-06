# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xvkbd/xvkbd-3.3.ebuild,v 1.1 2012/06/04 18:19:27 xmw Exp $

DESCRIPTION="virtual keyboard for X window system"
HOMEPAGE="http://homepage3.nifty.com/tsato/xvkbd/"
SRC_URI="http://homepage3.nifty.com/tsato/xvkbd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="x11-libs/libXtst
	x11-libs/libXmu
	x11-libs/libXaw
	x11-libs/libXaw3d
	x11-libs/libXt"
DEPEND="${RDEPEND}
	x11-misc/imake
	x11-misc/gccmakedep
	x11-proto/xproto
	x11-proto/inputproto
	app-text/rman
	x11-proto/xextproto"

src_compile() {
	xmkmf -a || die

	emake \
		XAPPLOADDIR="/usr/share/X11/app-defaults" \
		LOCAL_LDFLAGS="${LDFLAGS}" \
		CDEBUGFLAGS="${CFLAGS}" || die
}

src_install() {
	emake XAPPLOADDIR="/usr/share/X11/app-defaults" DESTDIR="${D}" \
		install || die

	rm -rf "${D}"/usr/lib "${D}"/etc

	dodoc README
	newman ${PN}.man ${PN}.1
}
