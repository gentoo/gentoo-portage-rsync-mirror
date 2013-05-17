# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-pipeline/django-pipeline-1.2.24.ebuild,v 1.1 2013/05/17 13:37:03 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="An asset packaging library for Django"
HOMEPAGE="http://pypi.python.org/pypi/django-pipeline/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=dev-python/django-1.4[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_compile_all() {
	use doc && emake -C docs html
	rm -f docs/_build/doctrees/environment.pickle || die
}

python_compile() {
	# Remove tests before reaching distutils-r1_src_install
	rm -rf tests/ || die
	distutils-r1_python_compile
}

python_install_all() {
	use doc && HTML_DOCS=( docs/_build/html/. )
	distutils-r1_python_install_all
}
