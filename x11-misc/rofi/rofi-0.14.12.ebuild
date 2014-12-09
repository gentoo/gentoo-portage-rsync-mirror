# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rofi/rofi-0.14.12.ebuild,v 1.1 2014/12/09 15:38:57 jer Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="A window switcher, run dialog and dmenu replacement"
HOMEPAGE="https://davedavenport.github.io/rofi/"
SRC_URI="https://github.com/DaveDavenport/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="i3"

RDEPEND="
	dev-libs/glib:2
	media-libs/freetype
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/pango
	i3? ( x11-wm/i3 )
"
DEPEND="
	${RDEPEND}
	x11-proto/xineramaproto
	x11-proto/xproto
	virtual/pkgconfig
"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-0.14.9-optional-i3.patch \
		"${FILESDIR}"/${PN}-0.14.12-run_test_sh.patch
	eautoreconf
}

src_configure() {
	econf $(use_with i3)
}

src_test() {
	emake test
}
