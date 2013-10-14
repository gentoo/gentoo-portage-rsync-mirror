# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eclean-kernel/eclean-kernel-9999.ebuild,v 1.7 2013/10/14 20:02:11 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} pypy2_0 )

inherit distutils-r1

#if LIVE
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"
inherit git-r3
#endif

DESCRIPTION="Remove outdated built kernels"
HOMEPAGE="https://bitbucket.org/mgorny/eclean-kernel/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="kernel_linux? ( dev-python/pymountboot[${PYTHON_USEDEP}] )"
#if LIVE

KEYWORDS=
SRC_URI=
#endif
