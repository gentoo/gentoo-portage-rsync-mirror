# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyliblzma/pyliblzma-0.5.3.ebuild,v 1.4 2012/05/04 15:12:17 patrick Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5 2.7-pypy-* *-jython"
DISTUTILS_SRC_TEST="setup.py"
PYTHON_MODNAME="liblzma.py"

inherit distutils

DESCRIPTION="Python bindings for liblzma"
HOMEPAGE="https://launchpad.net/pyliblzma http://pypi.python.org/pypi/pyliblzma"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-arch/xz-utils"
DEPEND="${RDEPEND}
	dev-python/setuptools
	virtual/pkgconfig"

DOCS="THANKS"
