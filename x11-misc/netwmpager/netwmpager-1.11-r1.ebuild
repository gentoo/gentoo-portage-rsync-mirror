# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/netwmpager/netwmpager-1.11-r1.ebuild,v 1.7 2012/05/05 04:53:42 jdhore Exp $

inherit eutils

DESCRIPTION="EWMH (NetWM) compatible pager. Works with Openbox and other EWMH
compliant window managers."
#HOMEPAGE="http://onion.dynserv.net/~timo/netwmpager.html" # bug 237240
HOMEPAGE="http://packages.gentoo.org/package/x11-misc/netwmpager"
SRC_URI="http://onion.dynserv.net/~timo/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXft
	x11-libs/libXdmcp
	x11-libs/libXau"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-desktop-switch.patch"
}

src_compile() {
	# econf does not work.
	./configure --prefix=/usr || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc config-example README

	# Don't install duplicate ungzipped config-example.
	rm -rf "${D}/usr/share/netwmpager/"
}
