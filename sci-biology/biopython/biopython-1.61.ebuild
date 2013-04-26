# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/biopython/biopython-1.61.ebuild,v 1.1 2013/04/26 10:15:58 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Python modules for computational molecular biology"
HOMEPAGE="http://www.biopython.org/ http://pypi.python.org/pypi/biopython/"
SRC_URI="http://www.biopython.org/DIST/${P}.tar.gz"

LICENSE="HPND"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mysql postgres"

RDEPEND="
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/networkx[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pygraphviz[${PYTHON_USEDEP}]
	dev-python/reportlab[${PYTHON_USEDEP}]
	media-gfx/pydot[${PYTHON_USEDEP}]
	mysql? ( dev-python/mysql-python[${PYTHON_USEDEP}] )
	postgres? ( dev-python/psycopg[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	sys-devel/flex"

#PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

#DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"
DOCS=( CONTRIB DEPRECATED NEWS README )
#PYTHON_MODNAME="Bio BioSQL"

#PATCHES=( "${FILESDIR}"/${PN}-1.51-flex.patch )

python_test() {
	cd Tests
	${PYTHON} run_tests.py
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /usr/share/doc/${PF}
	doins -r Doc/*
	insinto /usr/share/${PN}
	cp -r --preserve=mode Scripts Tests "${ED}"/usr/share/${PN} || die
}
