# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/canto/canto-0.7.10-r1.ebuild,v 1.1 2014/02/20 20:41:07 pinkbyte Exp $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1

DESCRIPTION="Ncurses RSS client"
HOMEPAGE="http://www.codezen.org/canto/"
SRC_URI="http://codezen.org/static/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="sys-libs/ncurses[unicode]
	dev-python/chardet[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
