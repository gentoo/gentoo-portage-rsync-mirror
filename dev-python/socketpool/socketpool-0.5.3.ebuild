# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/socketpool/socketpool-0.5.3.ebuild,v 1.1 2014/04/23 07:48:55 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} pypy )

inherit distutils-r1

DESCRIPTION="A simple Python socket pool"
HOMEPAGE="http://github.com/benoitc/socketpool/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86"
IUSE="examples +gevent test"
LICENSE="|| ( MIT public-domain )"
SLOT="0"

RDEPEND="gevent? ( dev-python/gevent[$(python_gen_usedep 'python2*')] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

PATCHES=( "${FILESDIR}"/${P/3/2}-locale.patch )

REQUIRED_USE="gevent? ( $(python_gen_useflags 'python2*') )"

python_test() {
	py.test tests || die
}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}
