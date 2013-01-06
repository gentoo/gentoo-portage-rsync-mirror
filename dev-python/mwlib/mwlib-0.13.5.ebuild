# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mwlib/mwlib-0.13.5.ebuild,v 1.2 2012/12/31 13:02:18 mgorny Exp $

EAPI="3"
PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 2.5 3.* 2.7-pypy-* *-jython"

inherit distutils

DESCRIPTION="Tools for parsing Mediawiki content to other formats"
HOMEPAGE="http://code.pediapress.com/wiki/wiki http://pypi.python.org/pypi/mwlib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/perl
	>=dev-python/flup-1.0
	dev-python/imaging
	>=dev-python/lockfile-0.8
	dev-python/lxml
	=dev-python/odfpy-0.9*
	>=dev-python/pyPdf-1.12
	virtual/pyparsing
	>=dev-python/timelib-0.2
	>=dev-python/twisted-9.0.0-r1
	>=dev-python/twisted-web-9.0.0
	>=dev-python/webob-0.9
	virtual/latex-base
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 >=dev-python/simplejson-1.3 )"
DEPEND="${RDEPEND}
	dev-python/setuptools"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
