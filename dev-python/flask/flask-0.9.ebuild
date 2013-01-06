# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-0.9.ebuild,v 1.2 2012/08/20 17:23:44 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_PN="Flask"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
HOMEPAGE="http://pypi.python.org/pypi/Flask"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples test"
# USE doc removed because it acquires content from the network in building

RDEPEND="dev-python/blinker
	>=dev-python/jinja-2.4
	dev-python/setuptools
	>=dev-python/werkzeug-0.6.1"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_test() {
	testing() {
		PYTHONPATH="." "$(PYTHON)" run-tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
