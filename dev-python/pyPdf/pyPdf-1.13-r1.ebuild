# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyPdf/pyPdf-1.13-r1.ebuild,v 1.2 2013/09/05 18:46:48 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1

DESCRIPTION="Python library to work with pdf files"
HOMEPAGE="http://pybrary.net/pyPdf/ http://pypi.python.org/pypi/pyPdf/"
SRC_URI="http://pybrary.net/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
