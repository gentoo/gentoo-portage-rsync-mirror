# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/geoip-python/geoip-python-1.2.8.ebuild,v 1.4 2013/05/20 12:42:23 ago Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* 2.5-jython"

inherit distutils

MY_PN="GeoIP-Python"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python bindings for GeoIP"
HOMEPAGE="http://www.maxmind.com/app/python"
SRC_URI="http://www.maxmind.com/download/geoip/api/python/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/geoip-1.4.8"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

DOCS="README ChangeLog test.py test_city.py test_org.py"
