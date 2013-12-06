# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libaosd/libaosd-0.2.7.ebuild,v 1.5 2013/12/06 07:59:10 polynomial-c Exp $

EAPI=5
inherit autotools-utils

DESCRIPTION="An advanced on screen display (OSD) library"
HOMEPAGE="https://github.com/atheme/libaosd"
SRC_URI="https://github.com/atheme/${PN}/archive/0.2.7.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="pango +tools xcomposite"

RDEPEND="x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXrender
	pango? ( x11-libs/pango )
	tools? ( dev-libs/glib:2 )
	xcomposite? ( x11-libs/libXcomposite )"
DEPEND="${RDEPEND}"

AUTOTOOLS_IN_SOURCE_BUILD=1
DOCS=( Changelog )

src_prepare() {
	eautoreconf
}

src_configure() {
	myeconfargs=(
		$(use_enable tools glib)
		$(use_enable pango pangocairo)
		$(use_enable xcomposite)
	)

	autotools-utils_src_configure
}
