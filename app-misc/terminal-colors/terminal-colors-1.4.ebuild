# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/terminal-colors/terminal-colors-1.4.ebuild,v 1.3 2012/12/13 21:34:04 radhermit Exp $

EAPI="4"
PYTHON_DEPEND="2"
PYTHON_USE_WITH="ncurses"

inherit python

DESCRIPTION="A tool to display color charts for 8, 16, 88, and 256 color terminals"
HOMEPAGE="http://zhar.net/projects/shell/terminal-colors"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.bz2"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}

src_prepare() {
	python_convert_shebangs 2 ${P}
}

src_install() {
	newbin ${P} ${PN}
}
