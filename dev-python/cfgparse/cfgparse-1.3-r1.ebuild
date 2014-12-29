# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cfgparse/cfgparse-1.3-r1.ebuild,v 1.1 2014/12/29 07:47:09 idella4 Exp $

EAPI="5"
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Config File parser for Python"
HOMEPAGE="http://cfgparse.sourceforge.net http://pypi.python.org/pypi/cfgparse"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"

LICENSE="PSF-2.3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

DOCS="README.txt docs/cfgparse.pdf"
