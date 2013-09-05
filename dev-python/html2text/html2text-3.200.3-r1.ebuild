# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html2text/html2text-3.200.3-r1.ebuild,v 1.2 2013/09/05 18:47:12 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Turn HTML into equivalent Markdown-structured text."
HOMEPAGE="http://www.aaronsw.com/2002/html2text/
	https://github.com/aaronsw/html2text http://pypi.python.org/pypi/html2text"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/chardet[${PYTHON_USEDEP}]
	dev-python/feedparser[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${PN}-rename.patch" )
