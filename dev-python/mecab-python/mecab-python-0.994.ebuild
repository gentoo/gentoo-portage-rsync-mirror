# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mecab-python/mecab-python-0.994.ebuild,v 1.1 2012/11/16 07:36:56 patrick Exp $

EAPI="4"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Python binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="http://mecab.googlecode.com/files/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=app-text/mecab-${PV}"
RDEPEND="${DEPEND}"

DOCS="test.py"
PYTHON_MODNAME="MeCab.py"

src_install() {
	distutils_src_install
	dohtml bindings.html || die
}
