# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/nml/nml-0.2.3.ebuild,v 1.9 2012/12/31 16:32:33 ago Exp $

EAPI=4
PYTHON_DEPEND="2:2.5"
inherit distutils

DESCRIPTION="Compiler of NML files into grf/nfo files"
HOMEPAGE="http://dev.openttdcoop.org/projects/nml"
SRC_URI="http://bundles.openttdcoop.org/${PN}/releases/${PV}/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86"
IUSE=""

RDEPEND="dev-python/imaging
	dev-python/ply"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="docs/changelog.txt docs/readme.txt"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install
	doman docs/nmlc.1
}
