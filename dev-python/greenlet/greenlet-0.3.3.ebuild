# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/greenlet/greenlet-0.3.3.ebuild,v 1.2 2012/02/20 14:51:40 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

DESCRIPTION="Lightweight in-process concurrent programming"
HOMEPAGE="http://pypi.python.org/pypi/greenlet"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools
	app-arch/unzip"
RDEPEND=""

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

DOCS="AUTHORS NEWS"
