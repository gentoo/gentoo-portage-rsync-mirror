# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/symbola/symbola-7.01.ebuild,v 1.4 2013/01/03 15:32:38 chithanh Exp $

EAPI=4

MY_PN="${PN/s/S}"

inherit font

DESCRIPTION="Unicode font for Basic Latin, IPA Extensions, Greek, Cyrillic and many Symbol Blocks"
HOMEPAGE="http://users.teilar.gr/~g1951d/"
SRC_URI="http://users.teilar.gr/~g1951d/${MY_PN}${PV/./}.zip"
LICENSE="Unicode_Fonts_for_Ancient_Scripts"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"
FONT_SUFFIX="ttf"

pkg_setup() {
	if use doc; then
		DOCS=( ${MY_PN}.pdf )
	fi
}
