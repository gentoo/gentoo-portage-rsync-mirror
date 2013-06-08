# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/multiprocessing/multiprocessing-2.6.2.1.ebuild,v 1.1 2013/06/08 14:28:05 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6} )

inherit distutils-r1

DESCRIPTION="A reusable application for the Django web framework"
HOMEPAGE="http://pypi.python.org/pypi/ordereddict/1.1"
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
