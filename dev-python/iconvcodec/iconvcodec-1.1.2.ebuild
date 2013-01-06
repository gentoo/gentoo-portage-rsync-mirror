# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/iconvcodec/iconvcodec-1.1.2.ebuild,v 1.10 2012/02/25 22:25:30 marienz Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
# On pypy-1.8: undefined symbol: PyUnicodeDecodeError_SetStart.
# Might start working in future pypys, but restrict for now.
RESTRICT_PYTHON_ABIS="3.* *-jython *-pypy-*"

inherit distutils

DESCRIPTION="Python Codecs for Iconv Encodings"
HOMEPAGE="http://cjkpython.i18n.org/"
SRC_URI="mirror://berlios/cjkpython/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ia64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

PYTHON_MODNAME="iconv_codec.py"

src_compile() {
	distutils_src_compile --with-libc
}
