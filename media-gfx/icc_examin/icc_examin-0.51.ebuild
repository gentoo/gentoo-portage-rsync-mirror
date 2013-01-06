# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/icc_examin/icc_examin-0.51.ebuild,v 1.2 2012/11/04 17:17:19 xmw Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="viewer for ICC and CGATS profiles, argylls gamut vrml visualisations and video card gamma tables"
HOMEPAGE="http://www.oyranos.org/icc-examin"
SRC_URI="mirror://sourceforge/oyranos/ICC%20Examin/ICC%20Examin%20${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/ftgl
	media-libs/oyranos
	x11-libs/fltk"

DEPEND="${RDEPEND}
	sys-devel/libtool"

src_prepare() {
	sed -e '/xdg-icon-resource\|xdg-desktop-menu/d' \
		-i makefile.in
}

src_configure() {
	tc-export CC CXX
	econf --enable-verbose \
		--disable-static
}
