# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-0.9-r2.ebuild,v 1.1 2013/05/23 00:32:56 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
MY_PN="Flask"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"
HOMEPAGE="http://pypi.python.org/pypi/Flask"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"

RDEPEND="dev-python/blinker[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.4[$(python_gen_usedep python2_5)]
	>=dev-python/jinja-2.4[$(python_gen_usedep python{2_6,2_7} 'pypy*')]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-0.6.1[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

python_test() {
	"${PYTHON}" run-tests.py || die "Testing failed with ${EPYTHON}"
}

python_install_all() {
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
