# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask-script/flask-script-0.5.3.ebuild,v 1.1 2013/01/22 11:58:45 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

MY_PN="Flask-Script"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Flask support for writing external scripts."
HOMEPAGE="http://packages.python.org/Flask-Script/ http://pypi.python.org/pypi/Flask-Script"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND="dev-python/flask
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )"

S="${WORKDIR}/${MY_P}"

python_compile_all() {
	if use doc; then
		einfo "Generation of documentation by" ${PYTHON}
		PYTHONPATH=".." emake -C docs html || die "Generation of documentation failed"
	fi
}

python_test() {
	nosetests -v || die
}

python_install_all() {
	use doc && dohtml -r docs/_build/html/
	dodoc README.rst
}
