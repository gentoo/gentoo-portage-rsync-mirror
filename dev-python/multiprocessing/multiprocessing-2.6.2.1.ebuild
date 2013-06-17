# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/multiprocessing/multiprocessing-2.6.2.1.ebuild,v 1.2 2013/06/17 04:27:56 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python2_5 )

inherit distutils-r1

DESCRIPTION="Backport of the multiprocessing package to Python 2.4 and 2.5"
HOMEPAGE="https://pypi.python.org/pypi/multiprocessing"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="doc"
LICENSE="BSD"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

python_compile_all() {
	use doc && sphinx-build -b html Doc/ glossary
}

python_install_all() {
	use doc && HTML_DOCS=( glossary/. )
	distutils-r1_python_install_all
}
