# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/slune/slune-1.0.15.ebuild,v 1.3 2011/04/06 19:56:01 arfrever Exp $

EAPI=3
PYTHON_DEPEND="2"
inherit python distutils

DESCRIPTION="A 3D action game with multiplayer mode and amazing graphics"
HOMEPAGE="http://oomadness.tuxfamily.org/en/slune/"
SRC_URI="http://download.gna.org/slune/Slune-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	>=media-libs/libsdl-1.2.6
	>=dev-python/soya-0.9
	>=dev-python/py2play-0.1.9
	>=dev-python/pyopenal-0.1.3
	>=dev-python/pyogg-1.1
	>=dev-python/pyvorbis-1.1"

S=${WORKDIR}/Slune-${PV}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	distutils_src_prepare
}
