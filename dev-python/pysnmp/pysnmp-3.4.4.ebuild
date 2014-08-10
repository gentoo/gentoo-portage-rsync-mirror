# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pysnmp/pysnmp-3.4.4.ebuild,v 1.5 2014/08/10 21:18:07 slyfox Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="SNMP framework in Python. Not a wrapper"
HOMEPAGE="http://pysnmp.sf.net/ http://pypi.python.org/pypi/pysnmp"
SRC_URI="mirror://sourceforge/pysnmp/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT_PYTHON_ABIS="3.*"

DOCS="CHANGES COMPATIBILITY README"

src_install(){
	distutils_src_install

	dohtml -r docs/
	insinto /usr/share/doc/${PF}
	doins -r examples
}
