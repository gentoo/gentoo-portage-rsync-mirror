# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geopy/geopy-0.94.2-r1.ebuild,v 1.1 2012/06/29 15:54:33 iksaif Exp $

EAPI="4"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"
DISTUTILS_SRC_TEST="nosetests"

inherit distutils

DESCRIPTION="A Geocoding Toolbox for Python"
HOMEPAGE="http://www.geopy.org/ http://pypi.python.org/pypi/geopy http://code.google.com/p/geopy/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
IUSE=""

RDEPEND="<=dev-python/beautifulsoup-4.0"
DEPEND="${RDEPEND}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
