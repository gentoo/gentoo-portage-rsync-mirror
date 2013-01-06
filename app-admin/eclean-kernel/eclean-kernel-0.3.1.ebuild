# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eclean-kernel/eclean-kernel-0.3.1.ebuild,v 1.3 2012/12/17 20:02:34 mgorny Exp $

EAPI=5

PYTHON_COMPAT=(python2_6 python2_7 python3_1 python3_2)
inherit distutils-r1

DESCRIPTION="Remove outdated built kernels"
HOMEPAGE="https://bitbucket.org/mgorny/eclean-kernel/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~mips ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="kernel_linux? ( dev-python/pymountboot[${PYTHON_USEDEP}] )"
