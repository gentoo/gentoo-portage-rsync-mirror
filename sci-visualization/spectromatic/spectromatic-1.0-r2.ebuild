# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/spectromatic/spectromatic-1.0-r2.ebuild,v 1.5 2012/08/07 02:33:07 bicatali Exp $

EAPI=4

inherit base toolchain-funcs

MY_P=${PN}_${PV}-1

DESCRIPTION="Generates time-frequency analysis images from wav files"
HOMEPAGE="http://ieee.uow.edu.au/~daniel/software/spectromatic/"
SRC_URI="http://ieee.uow.edu.au/~daniel/software/spectromatic/dist/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="media-libs/libpng
	sci-libs/gsl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS=( README )
PATCHES=(
	"${FILESDIR}"/${P}-makefile.patch
	"${FILESDIR}"/${P}-stringliteral.patch
	"${FILESDIR}"/${P}-waveheaderstruct-amd64.patch
)

pkg_setup() {
	tc-export CC
	export TOPLEVEL_HOME="${EROOT}/usr"
}
