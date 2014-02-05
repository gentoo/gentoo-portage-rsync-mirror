# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-iptables/python-iptables-0.3.0-r1.ebuild,v 1.1 2014/02/04 23:02:29 chutzpah Exp $

EAPI=5
PYTHON_COMPAT=(python2_7)
inherit distutils-r1

DESCRIPTION="Python bindings for iptables."
HOMEPAGE="https://github.com/ldx/python-iptables"
SRC_URI="https://github.com/ldx/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-firewall/iptables"
RDEPEND="${DEPEND}"

# tests manipulate live iptables rules, so disable them by default
RESTRICT=test

PATCHES=(
	"${FILESDIR}/${PN}-0.2.0-tests.patch"
	"${FILESDIR}/${P}-conntrack-fixes.patch"
)

python_test() {
	${PYTHON} test.py
}
