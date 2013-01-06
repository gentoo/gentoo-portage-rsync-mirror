# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kding/kding-0.6-r1.ebuild,v 1.4 2012/11/16 22:48:56 johu Exp $

EAPI=4
KDE_HANDBOOK="optional"
KDE_LINGUAS="de"
inherit kde4-base

DESCRIPTION="KDE port of Ding, a dictionary lookup program."
HOMEPAGE="http://www.rexi.org/software/kding/"
SRC_URI="http://www.rexi.org/downloads/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64 x86"
IUSE="debug"

PATCHES=( "${FILESDIR}"/${P}-dtd.patch )

src_prepare() {
	sed -e "/Encoding=UTF-8/d" \
		-i resources/kding.desktop || die "fixing .desktop file failed"

	kde4-base_src_prepare
}
