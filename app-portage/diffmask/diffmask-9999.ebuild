# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/diffmask/diffmask-9999.ebuild,v 1.9 2014/11/26 10:29:31 pacho Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4} pypy pypy2_0 )

inherit distutils-r1

#if LIVE
EGIT_REPO_URI="http://bitbucket.org/mgorny/${PN}.git"
inherit git-r3
#endif

DESCRIPTION="A utility to maintain package.unmask entries up-to-date with masks"
HOMEPAGE="https://bitbucket.org/mgorny/diffmask/"
SRC_URI="https://www.bitbucket.org/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-apps/portage[${PYTHON_USEDEP}]"
#if LIVE

KEYWORDS=
SRC_URI=
#endif
