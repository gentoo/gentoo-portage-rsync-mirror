# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-0.1.16.ebuild,v 1.1 2013/01/22 17:59:56 jer Exp $

EAPI=5
inherit eutils

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://pekwm.org/"
SRC_URI="http://pekwm.org/projects/pekwm/files/${P}.tar.bz2
	mirror://gentoo/${PN}-themes.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="debug truetype xinerama"

RDEPEND="virtual/jpeg
	media-libs/libpng
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	truetype? ( x11-libs/libXft )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_enable truetype xft) \
		$(use_enable xinerama) \
		--enable-image-jpeg \
		--enable-image-png \
		--enable-image-xpm \
		--enable-shape \
		--enable-xrandr
}

src_install() {
	default

	rm "${WORKDIR}/themes/Ace/.theme.swp"
	mv "${WORKDIR}/themes/"* "${D}/usr/share/${PN}/themes/"
}
