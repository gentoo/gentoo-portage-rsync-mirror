# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/txtorcon/txtorcon-0.11.0.ebuild,v 1.2 2014/12/13 08:22:01 mgorny Exp $

EAPI=5
PYTHON_COMPAT=(python2_7)

inherit distutils-r1

DESCRIPTION="Twisted-based Tor controller client, with state-tracking and configuration abstractions"
HOMEPAGE="https://github.com/meejah/txtorcon https://pypi.python.org/pypi/txtorcon"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-python/twisted-core[${PYTHON_USEDEP}]
	dev-python/ipaddr[${PYTHON_USEDEP}]
	net-misc/tor
	dev-python/zope-interface[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/mock[${PYTHON_USEDEP}] )"

python_test() {
	trial --reporter=text test || die
}
