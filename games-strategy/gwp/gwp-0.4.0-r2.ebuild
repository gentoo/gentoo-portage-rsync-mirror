# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/gwp/gwp-0.4.0-r2.ebuild,v 1.8 2014/06/25 06:04:59 mr_bones_ Exp $

EAPI=2
inherit eutils flag-o-matic gnome2

DESCRIPTION="GNOME client for the classic PBEM strategy game VGA Planets 3"
HOMEPAGE="http://gwp.lunix.com.ar/"
SRC_URI="http://gwp.lunix.com.ar/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls opengl python"

RDEPEND="x11-libs/gtk+:2
	=gnome-base/libgnomeui-2*
	=gnome-base/libglade-2*
	app-text/scrollkeeper
	dev-libs/libpcre
	nls? ( virtual/libintl )
	opengl? ( =x11-libs/gtkglext-1* )
	python? ( =dev-python/pygtk-2* )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	append-libs -lm
	gnome2_src_prepare
	epatch \
		"${FILESDIR}"/${P}-gcc41.patch \
		"${FILESDIR}"/${P}-exec-stack.patch
	sed -i \
		-e '/ -O1/d' \
		-e '/ -g$/d' \
		src/Makefile.in || die
}

src_configure() {
	gnome2_src_configure \
		$(use_enable nls) \
		$(use_enable opengl gtkglext) \
		$(use_enable python)
}

src_install() {
	DOCS="AUTHORS ChangeLog CHANGES README TODO" \
	gnome2_src_install
	rm -rf "${D}"/usr/share/doc/gwp
}
