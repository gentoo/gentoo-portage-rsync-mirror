# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/slmon/slmon-0.5.13.ebuild,v 1.6 2012/05/03 19:41:35 jdhore Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Colored text-based system performance monitor"
HOMEPAGE="http://slmon.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="debug"

RDEPEND="dev-libs/glib:2
	sys-libs/slang
	gnome-base/libgtop"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-make-382.patch \
		"${FILESDIR}"/${P}-invalid-free.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README slmonrc TODO
	dohtml *.html
}
