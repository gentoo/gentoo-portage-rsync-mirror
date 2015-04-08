# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html2text/html2text-3.200.3.ebuild,v 1.5 2014/08/10 21:11:59 slyfox Exp $

EAPI=3

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="Turn HTML into equivalent Markdown-structured text"
HOMEPAGE="http://www.aaronsw.com/2002/html2text/
	https://github.com/aaronsw/html2text http://pypi.python.org/pypi/html2text"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/chardet
	dev-python/feedparser
	dev-python/setuptools"
DEPEND="${RDEPEND}"

PYTHON_MODNAME="${PN}.py"
