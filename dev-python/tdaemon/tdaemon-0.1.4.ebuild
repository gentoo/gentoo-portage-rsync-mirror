# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/tdaemon/tdaemon-0.1.4.ebuild,v 1.1 2013/06/13 08:14:00 tampakrap Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Test Daemon"
HOMEPAGE="http://github.com/brunobord/tdaemon"
SRC_URI="https://github.com/tampakrap/tdaemon/archive/v${PV}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="coverage"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/notify-python[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
	coverage? ( dev-python/coverage[${PYTHON_USEDEP}] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_test() {
	if "${PYTHON}" -m test; then
		einfo "Test passed under ${EPYTHON}"
	else
		die "Test failed under ${EPYTHON}"
	fi
}
