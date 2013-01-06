# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/gsl-shell/gsl-shell-2.2.0.ebuild,v 1.1 2012/11/30 17:34:03 grozin Exp $

EAPI=4
inherit eutils

DESCRIPTION="Lua interactive shell for sci-libs/gsl"
HOMEPAGE="http://www.nongnu.org/gsl-shell/"
SRC_URI="http://download.savannah.gnu.org/releases/${PN}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc fox"

DEPEND=">=sci-libs/gsl-1.14
	virtual/blas
	>=x11-libs/agg-2.5
	>=media-libs/freetype-2.4.10
	sys-libs/readline
	|| ( media-fonts/ubuntu-font-family media-fonts/freefont-ttf media-fonts/dejavu )
	doc? ( dev-python/sphinx[latex] )
	fox? ( x11-libs/fox:1.6 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-font.patch "${FILESDIR}"/${PN}-strip.patch "${FILESDIR}"/${PN}-usr.patch
	use fox || epatch "${FILESDIR}"/${PN}-nogui.patch
}

src_compile() {
	local BLAS=`pkg-config --libs blas`

	if use fox; then
		local FOX_INCLUDES=`WANT_FOX=1.6 fox-config --cflags`
		local FOX_LIBS=`WANT_FOX=1.6 fox-config --libs`
		emake -j1 CFLAGS="${CFLAGS}" GSL_LIBS="-lgsl ${BLAS}" \
			FOX_INCLUDES="${FOX_INCLUDES}" FOX_LIBS="${FOX_LIBS}"
	else
		emake -j1 CFLAGS="${CFLAGS}" GSL_LIBS="-lgsl ${BLAS}"
	fi

	if use doc; then
		pushd doc/user-manual > /dev/null
		emake -j1 html
		popd > /dev/null
	fi
}

src_install() {
	default
	use doc && dohtml -r doc/user-manual/_build/html/*
}
