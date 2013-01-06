# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyPdf/pyPdf-1.13.ebuild,v 1.3 2011/01/11 15:36:25 phajdan.jr Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Python library to work with pdf files"
HOMEPAGE="http://pybrary.net/pyPdf/ http://pypi.python.org/pypi/pyPdf"
SRC_URI="http://pybrary.net/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"
