# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fireflies/fireflies-2.07.ebuild,v 1.9 2013/01/12 11:46:27 ulm Exp $

inherit eutils multilib

DESCRIPTION="Fireflies screensaver: Wicked cool eye candy"
HOMEPAGE="http://somewhere.fscked.org/proj/fireflies/"
SRC_URI="http://somewhere.fscked.org/proj/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2 HPND"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/mesa
	media-libs/libsdl
	x11-libs/libX11"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.06-configure.patch \
		"${FILESDIR}"/${PN}-2.06-Make.include.in.patch
	sed -i -e 's:strip:true:' src/Makefile
	sed -i -e '/gunzip/d' Makefile
	tar xzf libgfx-1.0.1.tar.gz
	epatch "${FILESDIR}"/${PN}-2.07-gcc43.patch
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_compile() {
	econf --with-confdir=/usr/share/xscreensaver/config \
		--with-bindir=/usr/$(get_libdir)/misc/xscreensaver
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README TODO
}
