# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/gunicorn/gunicorn-0.14.6.ebuild,v 1.1 2012/07/30 05:30:20 rafaelmartins Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.* *-jython"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils eutils

DESCRIPTION="A WSGI HTTP Server for UNIX"
HOMEPAGE="http://gunicorn.org http://pypi.python.org/pypi/gunicorn"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE="doc test"
KEYWORDS="~amd64 ~x86"

# tests are failing randomly.
RESTRICT="test"

RDEPEND="dev-python/setproctitle"
DEPEND="dev-python/setuptools"

DOCS="README.rst"

src_prepare() {
	epatch "${FILESDIR}/${PN}"-0.14.0-noegg.patch || die
}

src_install() {
	distutils_src_install
	use doc && dohtml -r doc/htdocs/*
}
