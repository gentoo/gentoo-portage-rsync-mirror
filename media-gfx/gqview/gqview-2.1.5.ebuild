# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-2.1.5.ebuild,v 1.16 2012/07/26 18:41:29 blueness Exp $

EAPI=2
inherit eutils

DESCRIPTION="A GTK-based image browser"
HOMEPAGE="http://gqview.sourceforge.net/"
SRC_URI="mirror://sourceforge/gqview/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ~mips ppc ppc64 sparc x86"
IUSE="lcms"

RDEPEND=">=x11-libs/gtk+-2.4:2
	lcms? ( media-libs/lcms:0 )
	virtual/libintl"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	epatch "${FILESDIR}/${P}-windows.patch"
	sed -i \
		-e '/^Encoding/d' \
		-e '/^Icon/s/\.png//' \
		-e '/^Categories/s/Application;//' \
		gqview.desktop \
		|| die
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_with lcms)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	# leave README uncompressed because the program reads it
	dodoc AUTHORS ChangeLog TODO
	rm -f "${D}/usr/share/doc/${PF}/COPYING"
}
