# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-emnu/embassy-emnu-1.05.650.ebuild,v 1.1 2015/03/28 17:24:57 jlec Exp $

EAPI=5

EBO_DESCRIPTION="Simple menu of EMBOSS applications"
EBO_EXTRA_ECONF="$(use_enable ncurses curses)"

PATCHES=( "${FILESDIR}"/${P}_fix-build-system.patch )
AUTOTOOLS_AUTORECONF=1
inherit emboss-r1

KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos"
IUSE+=" ncurses"

RDEPEND+=" ncurses? ( sys-libs/ncurses )"
