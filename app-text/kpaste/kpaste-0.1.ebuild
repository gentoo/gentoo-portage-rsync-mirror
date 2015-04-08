# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kpaste/kpaste-0.1.ebuild,v 1.1 2011/12/31 04:57:04 floppym Exp $

EAPI="4"

PYTHON_DEPEND="2:2.6"

inherit python

DESCRIPTION="Command-line tool to paste to paste.kde.org"
HOMEPAGE="http://quickgit.kde.org/?p=kpaste.git"
SRC_URI="http://dev.gentoo.org/~floppym/distfiles/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	:
}

src_install() {
	dobin kpaste
	dodoc README
}
