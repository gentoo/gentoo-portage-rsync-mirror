# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/qserve/qserve-0.2.7.ebuild,v 1.1 2012/05/18 11:39:35 xarthisius Exp $

EAPI=4

SUPPORT_PYTHON_ABIS=1
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST=py.test

inherit distutils

DESCRIPTION="A job queue server"
HOMEPAGE="https://github.com/pediapress/qserve http://pypi.python.org/pypi/qserve/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/gevent
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 dev-python/simplejson )"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-python/setuptools"

PYTHON_MODNAME="qs"
