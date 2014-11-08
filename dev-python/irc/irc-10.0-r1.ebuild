# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/irc/irc-10.0-r1.ebuild,v 1.1 2014/11/08 04:40:35 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

inherit distutils-r1

DESCRIPTION="IRC client framework written in Python"
HOMEPAGE="https://bitbucket.org/jaraco/irc http://pypi.python.org/pypi/irc"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND="
	!>=dev-python/python-irclib-3.2.2[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/jaraco-utils[${PYTHON_USEDEP}]"

DEPEND="app-arch/unzip
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/hgtools-5[${PYTHON_USEDEP}]
	dev-python/pytest-runner[${PYTHON_USEDEP}]
	test? ( ${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/mock[${PYTHON_USEDEP}]' python2_7) )"

# A doc folder is present however it appears to be used for doctests
python_prepare_all() {
	# https://bitbucket.org/jaraco/irc/commits/2074d84fa635. sed lighter weight than a full patch
	sed -e 's:key_transform(key):transform_key(key):' -i irc/dict.py || die
	distutils-r1_python_prepare_all
}

python_test() {
	py.test irc/tests || die "Tests failed under ${EPYTHON}"
}

python_install_all() {
	use examples && local EXAMPLES=( scripts/. )
	distutils-r1_python_install_all
}
