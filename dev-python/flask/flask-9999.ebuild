# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/flask/flask-9999.ebuild,v 1.2 2012/04/10 13:01:00 rafaelmartins Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"

EGIT_REPO_URI="git://github.com/mitsuhiko/flask.git
	https://github.com/mitsuhiko/flask.git"

inherit distutils git-2

MY_PN="Flask"

DESCRIPTION="A microframework based on Werkzeug, Jinja2 and good intentions"
HOMEPAGE="http://pypi.python.org/pypi/Flask"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc examples test"

RDEPEND="dev-python/blinker
	>=dev-python/jinja-2.4
	dev-python/setuptools
	>=dev-python/werkzeug-0.6.1"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )"

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
