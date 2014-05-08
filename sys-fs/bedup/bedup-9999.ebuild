# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/bedup/bedup-9999.ebuild,v 1.5 2014/05/08 22:23:31 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_2,3_3} )

#if LIVE
EGIT_REPO_URI="git://github.com/g2p/bedup.git
	https://github.com/g2p/bedup.git"
inherit git-r3
#endif

inherit distutils-r1

DESCRIPTION="Btrfs file de-duplication tool"
HOMEPAGE="https://github.com/g2p/bedup"
SRC_URI="https://github.com/g2p/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# we need btrfs-progs with includes installed.
DEPEND=">=dev-python/cffi-0.5:=[${PYTHON_USEDEP}]
	>=sys-fs/btrfs-progs-0.20_rc1_p358"
RDEPEND="${DEPEND}
	dev-python/alembic[${PYTHON_USEDEP}]
	dev-python/contextlib2[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/sqlalchemy[sqlite,${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]"

#if LIVE
SRC_URI=
KEYWORDS=
#endif
