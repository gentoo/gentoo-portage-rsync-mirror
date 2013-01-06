# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/netwmpager/netwmpager-2.04.ebuild,v 1.3 2012/08/04 18:25:04 johu Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="EWMH (NetWM) compatible pager. Works with Openbox and other EWMH
compliant window managers."
HOMEPAGE="http://sourceforge.net/projects/sf-xpaint/files/netwmpager/"
SRC_URI="mirror://sourceforge/sf-xpaint/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXft
	x11-libs/libXdmcp
	x11-libs/libXau"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

src_configure() {
	# econf doesn't work
	tc-export CC
	./configure --prefix=/usr || die

}

src_install () {
	default

	dodoc Changelog
}
