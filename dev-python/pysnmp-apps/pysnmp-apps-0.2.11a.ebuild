# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp-apps/pysnmp-apps-0.2.11a.ebuild,v 1.1 2010/12/23 16:04:12 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="PySNMP applications"
HOMEPAGE="http://pysnmp.sf.net/ http://pypi.python.org/pypi/pysnmp-apps"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/pysnmp-4.1.10a
	>=dev-python/pysnmp-mibs-0.0.6a"
DEPEND="${RDEPEND}
	dev-python/setuptools"

DOCS="CHANGES README"
PYTHON_MODNAME="pysnmp_apps"
