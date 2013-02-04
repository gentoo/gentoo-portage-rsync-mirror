# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyproj/pyproj-1.9.3.ebuild,v 1.1 2013/02/04 03:29:16 patrick Exp $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython 2.7-pypy-*"

inherit distutils

DESCRIPTION="Python interface to PROJ.4 library"
HOMEPAGE="http://code.google.com/p/pyproj/ http://pypi.python.org/pypi/pyproj"
SRC_URI="http://pyproj.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE="doc"

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

src_install(){
	distutils_src_install
	use doc && dohtml -r docs/*
}
