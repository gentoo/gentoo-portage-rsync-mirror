# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tdaemon/tdaemon-0.1.3.ebuild,v 1.1 2013/06/12 14:06:53 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Test Daemon"
HOMEPAGE="http://github.com/brunobord/tdaemon"
SRC_URI="https://github.com/tampakrap/tdaemon/archive/v0.1.3.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE=""
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/notify-python[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/setup.patch )

python_test() {
	if "${PYTHON}" -m test; then
		einfo "Test passed under ${EPYTHON}"
	else
		die "Test failed under ${EPYTHON}"
	fi
}
