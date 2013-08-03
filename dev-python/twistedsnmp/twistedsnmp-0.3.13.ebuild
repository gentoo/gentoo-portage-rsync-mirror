# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twistedsnmp/twistedsnmp-0.3.13.ebuild,v 1.3 2013/08/03 09:45:50 mgorny Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="TwistedSNMP"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SNMP protocols and APIs for use with the Twisted networking framework"
HOMEPAGE="http://twistedsnmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="=dev-python/pysnmp-3*
	>=dev-python/twisted-core-1.3"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	distutils_src_prepare

	# Disable broken test.
	sed -e "s/test_tableGetWithStart/_&/" -i test/test_get.py || die "sed failed"
}

src_test() {
	testing() {
		PYTHONPATH="build-${PYTHON_ABI}/lib" "$(PYTHON)" test/test.py
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install
	dohtml doc/index.html
	insinto /usr/share/doc/${PF}/html/style/
	doins doc/style/sitestyle.css
}
