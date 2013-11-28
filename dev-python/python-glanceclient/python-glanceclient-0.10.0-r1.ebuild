# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-glanceclient/python-glanceclient-0.10.0-r1.ebuild,v 1.1 2013/11/28 13:03:45 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A client for the OpenStack Glance API"
HOMEPAGE="https://github.com/openstack/python-glanceclient"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
		test? ( dev-python/mox[${PYTHON_USEDEP}]
				dev-python/coverage[${PYTHON_USEDEP}]
				>=dev-python/pep8-1.3.3[${PYTHON_USEDEP}]
				>=dev-python/setuptools-git-0.4[${PYTHON_USEDEP}]
				>=dev-python/sphinx-1.1.2[${PYTHON_USEDEP}]
				>=dev-python/testrepository-0.0.13[${PYTHON_USEDEP}]
				>=dev-python/testtools-0.9.22[${PYTHON_USEDEP}]
				=dev-python/pyflakes-0.7.2[${PYTHON_USEDEP}]
				>=dev-python/flake8-2.0[${PYTHON_USEDEP}]
				>=dev-python/hacking-0.5.3[${PYTHON_USEDEP}]
				<dev-python/hacking-0.6[${PYTHON_USEDEP}]
				dev-python/mox[${PYTHON_USEDEP}]
				>=dev-python/mock-0.8.0[${PYTHON_USEDEP}]
			)
		doc? ( dev-python/sphinx )
	"
RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]
		>=dev-python/d2to1-0.2.10[${PYTHON_USEDEP}]
		<dev-python/d2to1-0.3[${PYTHON_USEDEP}]
		>=dev-python/pbr-0.5[${PYTHON_USEDEP}]
		<dev-python/pbr-0.6[${PYTHON_USEDEP}]
		>=dev-python/python-keystoneclient-0.2.1[${PYTHON_USEDEP}]
		<dev-python/python-keystoneclient-1[${PYTHON_USEDEP}]
		>=dev-python/prettytable-0.6[${PYTHON_USEDEP}]
		<dev-python/prettytable-0.8[${PYTHON_USEDEP}]
		dev-python/pyopenssl[${PYTHON_USEDEP}]
		>=dev-python/warlock-0.7.0[${PYTHON_USEDEP}]
		<dev-python/warlock-2[${PYTHON_USEDEP}]"

python_prepare_all() {
	sed -e 's:intersphinx_mapping:_&:' -i doc/source/conf.py || die
	distutils-r1_python_prepare_all
}

python_compile_all() {
	use doc && esetup.py build_sphinx
}

python_test() {
	testr init
	testr run || die "testsuite failed under python2.7"
	flake8 tests && einfo "run flake8 over tests folder passed" || die
}

python_install_all() {
	use doc && local HTML_DOCS=( doc/build/html/. )
	distutils-r1_python_install_all
}
