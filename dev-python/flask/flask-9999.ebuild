# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-9999.ebuild,v 1.6 2013/06/27 02:24:57 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit distutils-r1
#if LIVE
inherit git-2
EGIT_REPO_URI="git://github.com/mitsuhiko/flask.git
	https://github.com/mitsuhiko/flask.git"
#endif

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
	>=dev-python/itsdangerous-0.21[${PYTHON_USEDEP}]
	>=dev-python/jinja-2.4[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/werkzeug-0.7[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"
#if LIVE
SRC_URI=
KEYWORDS=
#endif

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
