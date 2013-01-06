# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdfminer/pdfminer-20110515.ebuild,v 1.1 2011/06/20 12:41:04 hwoarang Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="Python tool for extracting information from PDF documents"
HOMEPAGE="http://www.unixuser.org/~euske/python/pdfminer/ http://pypi.python.org/pypi/pdfminer/"
SRC_URI="mirror://pypi/p/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
