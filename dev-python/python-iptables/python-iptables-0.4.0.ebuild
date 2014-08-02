# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-iptables/python-iptables-0.4.0.ebuild,v 1.1 2014/08/02 21:16:03 chutzpah Exp $

EAPI=5
PYTHON_COMPAT=(python2_7)
inherit distutils-r1

DESCRIPTION="Python bindings for iptables."
HOMEPAGE="https://github.com/ldx/python-iptables"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-firewall/iptables"
RDEPEND="${DEPEND}"

# tests manipulate live iptables rules, so disable them by default
RESTRICT=test
# needed for running tests
#RESTRICT=userpriv

PATCHES=(
	"${FILESDIR}/${PN}-0.2.0-tests.patch"
)

python_test() {
	${PYTHON} test.py || die "tests fail with ${EPYTHON}"
}
