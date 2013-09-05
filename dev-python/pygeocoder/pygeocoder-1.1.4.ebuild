# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pygeocoder/pygeocoder-1.1.4.ebuild,v 1.2 2013/09/05 18:47:12 mgorny Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1

DESCRIPTION="Python wrapper for Google Geocoding API V3"
HOMEPAGE="http://code.xster.net/pygeocoder/overview"
SRC_URI="http://code.xster.net/${PN}/downloads/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/python-json"
RDEPEND="${DEPEND}"
