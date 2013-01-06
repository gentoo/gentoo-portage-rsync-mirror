# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyproj/pyproj-1.8.9.ebuild,v 1.2 2012/02/20 14:58:50 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Python interface to PROJ.4 library"
HOMEPAGE="http://code.google.com/p/pyproj/ http://pypi.python.org/pypi/pyproj"
SRC_URI="http://pyproj.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")
