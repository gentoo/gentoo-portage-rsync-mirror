# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/nml/nml-0.2.4-r1.ebuild,v 1.4 2013/07/20 16:09:22 mr_bones_ Exp $

EAPI=5

PYTHON_COMPAT=( python2_5 python2_6 python2_7 )

inherit eutils distutils-r1

DESCRIPTION="Compiler of NML files into grf/nfo files"
HOMEPAGE="http://dev.openttdcoop.org/projects/nml"
SRC_URI="http://bundles.openttdcoop.org/nml/releases/${PV}/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc x86"
IUSE=""

RDEPEND="virtual/python-imaging
	dev-python/ply"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS=( docs/{changelog,readme}.txt )

src_prepare() {
	epatch "${FILESDIR}"/${P}-pillow.patch
}

src_install() {
	distutils-r1_src_install
	doman docs/nmlc.1
}
