# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/mecab-python/mecab-python-0.996.ebuild,v 1.3 2013/08/03 09:09:07 hattya Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_{5,6,7},3_{1,2,3}} )

inherit distutils-r1

DESCRIPTION="Python binding for MeCab"
HOMEPAGE="http://mecab.sourceforge.net/"
SRC_URI="http://mecab.googlecode.com/files/${P}.tar.gz"

LICENSE="|| ( BSD LGPL-2.1 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc64 ~x86"
IUSE=""

DEPEND="~app-text/mecab-${PV}"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-py3.diff" )
DOCS=( test.py )
HTML_DOCS=( bindings.html )
