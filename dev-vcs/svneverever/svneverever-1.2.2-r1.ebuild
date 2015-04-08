# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/svneverever/svneverever-1.2.2-r1.ebuild,v 1.2 2014/12/08 15:13:16 sping Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_7,3_1,3_3,3_4} )
inherit distutils-r1

DESCRIPTION="Tool collecting path entries across SVN history"
HOMEPAGE="https://github.com/hartwork/svneverever"
SRC_URI="http://www.hartwork.org/public/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pysvn[${PYTHON_USEDEP}]"
