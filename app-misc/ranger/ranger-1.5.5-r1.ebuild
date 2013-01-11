# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ranger/ranger-1.5.5-r1.ebuild,v 1.1 2013/01/11 22:22:22 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )
PYTHON_REQ_USE="ncurses"

inherit distutils-r1

DESCRIPTION="A vim-inspired file manager for the console"
HOMEPAGE="http://ranger.nongnu.org/"
SRC_URI="http://nongnu.org/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/pager"

pkg_postinst() {
	elog "Ranger has many optional dependencies to support enhanced file previews."
	elog "See the README or homepage for more details."
}
