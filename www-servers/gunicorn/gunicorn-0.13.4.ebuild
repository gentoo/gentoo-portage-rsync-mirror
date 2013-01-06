# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gunicorn/gunicorn-0.13.4.ebuild,v 1.3 2012/01/28 15:16:40 phajdan.jr Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"

inherit distutils

DESCRIPTION="A WSGI HTTP Server for UNIX, fast clients and nothing else"
HOMEPAGE="http://gunicorn.org http://pypi.python.org/pypi/gunicorn"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="doc examples test"
KEYWORDS="amd64 x86"

RDEPEND="dev-python/setproctitle"
DEPEND="dev-python/setuptools
	test? ( dev-python/nose )"

# tests are failing randomly.
RESTRICT="test"

DOCS="README.rst"

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/htdocs/*
	insinto "/usr/share/doc/${PF}"
	use examples && doins -r examples
}

src_test() {
	# distutils_src_test doesn't works if gunicorn isn't installed yet
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" setup.py test
	}
	python_execute_function testing
}
