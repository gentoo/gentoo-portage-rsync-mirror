# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/watchdog/watchdog-0.7.1.ebuild,v 1.1 2014/03/30 19:57:21 hasufell Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )
inherit distutils-r1

DESCRIPTION="Python API and shell utilities to monitor file system events"
HOMEPAGE="http://github.com/gorakhargosh/watchdog"
SRC_URI="mirror://pypi/w/watchdog/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/argh[${PYTHON_USEDEP}]
	dev-python/pathtools[${PYTHON_USEDEP}]"

pkg_postinst() {
	elog "optional dependencies:"
	elog "  dev-python/argcomplete (bash completion)"
}
