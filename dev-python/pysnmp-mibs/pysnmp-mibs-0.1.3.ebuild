# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-mibs/pysnmp-mibs-0.1.3.ebuild,v 1.1 2012/05/18 05:16:45 patrick Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="*-jython"

inherit distutils

DESCRIPTION="SNMP framework in Python - MIBs"
HOMEPAGE="http://pysnmp.sf.net/ http://pypi.python.org/pypi/pysnmp-mibs"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/pysnmp-4.1.16a"
RDEPEND="${DEPEND}
	dev-python/setuptools"

DOCS="CHANGES README"
PYTHON_MODNAME="pysnmp_mibs"
