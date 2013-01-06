# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/html2text/html2text-3.02.ebuild,v 1.3 2011/05/24 20:58:54 maekke Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="Turn HTML into equivalent Markdown-structured text."
HOMEPAGE="http://www.aaronsw.com/2002/html2text/ https://github.com/aaronsw/html2text http://pypi.python.org/pypi/html2text"
SRC_URI="https://github.com/aaronsw/html2text/tarball/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-python/chardet
	dev-python/feedparser"
DEPEND="${RDEPEND}
	dev-python/setuptools"

S="${WORKDIR}/aaronsw-${PN}-d9bf7d6"

PYTHON_MODNAME="html2text.py"
