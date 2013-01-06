# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-0.1.11.ebuild,v 1.8 2010/11/08 18:49:50 xarthisius Exp $

EAPI=2
inherit eutils

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://pekwm.org/"
SRC_URI="http://pekwm.org/projects/pekwm/files/${P}.tar.bz2
	mirror://gentoo/${PN}-themes.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc sparc x86 ~x86-fbsd"
IUSE="debug truetype xinerama"

DEPEND="virtual/jpeg
	media-libs/libpng
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	truetype? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${DEPEND}
	x11-apps/xprop"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libpng14.patch
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable truetype xft) \
		$(use_enable xinerama) \
		--enable-harbour \
		--enable-image-jpeg \
		--enable-image-png \
		--enable-image-xpm \
		--enable-menus \
		--enable-shape \
		--enable-xrandr
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README

	rm "${WORKDIR}/themes/Ace/.theme.swp"
	mv "${WORKDIR}/themes/"* "${D}/usr/share/${PN}/themes/"
}
