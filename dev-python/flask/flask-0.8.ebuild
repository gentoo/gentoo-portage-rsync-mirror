# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-0.8.ebuild,v 1.3 2011/10/08 19:13:50 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

inherit distutils

MY_PN="Flask"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
HOMEPAGE="http://pypi.python.org/pypi/Flask"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples test"

RDEPEND="dev-python/blinker
	>=dev-python/jinja-2.4
	dev-python/setuptools
	>=dev-python/werkzeug-0.6.1"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# Fixed an issue with an unused module for Python 2.5 (flask.session)
	# https://github.com/mitsuhiko/flask/commit/0dd9dc37b6618b8091c2a0f849f5f3143dc6eafc
	sed -e "s/\(from .sessions import\).*/\1 SecureCookieSession, NullSession/" -i flask/session.py || die
}

src_compile() {
	distutils_src_compile

	if use doc; then
		einfo "Generation of documentation"
		pushd docs > /dev/null
		PYTHONPATH=".." emake html || die "Generation of documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	testing() {
		PYTHONPATH="." "$(PYTHON)" run-tests.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd docs/_build/html > /dev/null
		insinto /usr/share/doc/${PF}/html
		doins -r [a-z]* _images _static || die "Installation of documentation failed"
		popd > /dev/null
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Installation of examples failed"
	fi
}
