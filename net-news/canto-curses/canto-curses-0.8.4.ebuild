# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/canto-curses/canto-curses-0.8.4.ebuild,v 1.2 2014/11/26 16:12:13 pacho Exp $

EAPI="5"

PYTHON_COMPAT=( python{3_2,3_3,3_4} )
PYTHON_REQ_USE="ncurses"
inherit distutils-r1

DESCRIPTION="The ncurses client for canto-daemon"
HOMEPAGE="http://codezen.org/canto-ng/"
SRC_URI="http://codezen.org/static/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=net-news/canto-daemon-0.8.2[${PYTHON_USEDEP}]"
