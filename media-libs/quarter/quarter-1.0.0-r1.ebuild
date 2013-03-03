# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/quarter/quarter-1.0.0-r1.ebuild,v 1.5 2013/03/02 21:48:45 hwoarang Exp $

EAPI="2"

inherit base

MY_P="${P/q/Q}"

DESCRIPTION="A glue between Nokia Qt4 and Coin3D"
HOMEPAGE="http://www.coin3d.org/lib/quarter"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/all/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="debug doc static-libs"

RDEPEND="
	>=media-libs/coin-3.0.0[javascript]
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtopengl:4
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}/${P}-gcc44.patch"
)

DOCS=(AUTHORS NEWS README)

src_configure() {
	# Bug 336008
	MAKEOPTS=-j1

	econf \
		htmldir="${ROOT}usr/share/doc/${PF}/html" \
		--enable-pkgconfig \
		--enable-shared \
		--with-coin \
		$(use_enable debug) \
		$(use_enable debug symbols) \
		$(use_enable doc html) \
		$(use_enable static-libs static)
}

src_install() {
	base_src_install

	# Do not install .la files
	rm -f "${D}"/usr/lib*/qt4/plugins/designer/*.{la,a}
	use static-libs || rm -f "${D}"/usr/lib*/*.la
}
