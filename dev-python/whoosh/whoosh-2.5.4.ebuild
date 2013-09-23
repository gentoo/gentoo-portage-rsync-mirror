# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/whoosh/whoosh-2.5.4.ebuild,v 1.1 2013/09/23 02:53:04 patrick Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

MY_PN="Whoosh"

inherit distutils-r1

DESCRIPTION="Fast, pure-Python full text indexing, search and spell checking library"
HOMEPAGE="http://bitbucket.org/mchaput/whoosh/wiki/Home/ http://pypi.python.org/pypi/Whoosh/"
SRC_URI="mirror://pypi/W/${MY_PN}/${MY_PN}-${PV}.tar.gz"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

S="${WORKDIR}/${MY_PN}-${PV}"

python_prepare_all() {
	# (backport from upstream)
	sed -i -e '/cmdclass/s:pytest:PyTest:' setup.py || die
	distutils-r1_python_prepare_all
}

python_install_all() {
	local DOCS=( README.txt )
	use doc && local HTML_DOCS=( docs/build/html/_sources/. )
	distutils-r1_python_install_all
}

python_test() {
	esetup.py test
}
