# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/columnize/columnize-0.3.3.ebuild,v 1.4 2014/08/10 21:09:00 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="Format a simple (i.e. not nested) list into aligned columns"
HOMEPAGE="http://code.google.com/p/pycolumnize/ http://pypi.python.org/pypi/columnize"
SRC_URI="http://pycolumnize.googlecode.com/files/${P}.tar.gz"

LICENSE="PSF-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

DOCS="README.txt"
PYTHON_MODNAME="columnize.py"
