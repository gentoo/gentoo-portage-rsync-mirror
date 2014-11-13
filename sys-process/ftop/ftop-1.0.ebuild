# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/ftop/ftop-1.0.ebuild,v 1.3 2014/11/13 01:41:23 jer Exp $

EAPI="5"

AUTOTOOLS_AUTORECONF=frob
inherit autotools-utils

DESCRIPTION="Monitor open files and filesystems"
HOMEPAGE="https://code.google.com/p/ftop/"
SRC_URI="https://${PN}.googlecode.com/files/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa"

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-overflow.patch
	"${FILESDIR}"/${P}-tinfo.patch
)
