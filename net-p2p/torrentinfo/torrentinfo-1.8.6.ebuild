# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/torrentinfo/torrentinfo-1.8.6.ebuild,v 1.3 2013/06/25 12:52:59 ago Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2} )

inherit distutils-r1

DESCRIPTION="A torrent file parser"
HOMEPAGE="https://github.com/ShanaTsunTsunLove/torrentinfo"
SRC_URI="https://github.com/ShanaTsunTsunLove/torrentinfo/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="virtual/python-argparse[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	test? ( dev-python/nose[${PYTHON_USEDEP}] )
"

python_test() {
	nosetests -v test/tests.py || die "Tests fail with ${EPYTHON}"
}
