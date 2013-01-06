# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/yablex/yablex-20030826.ebuild,v 1.7 2012/12/11 09:56:51 xarthisius Exp $

inherit eutils

MY_P=${PN}${PV}
DESCRIPTION="YaBle - Yet Another Blender Exporter"
HOMEPAGE="http://www.kino3d.com/~yable/"
SRC_URI="mirror://gentoo/${MY_P}-leope.zip"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="app-arch/unzip"
RDEPEND="media-gfx/blender
	dev-lang/python"

S=${WORKDIR}

src_unpack() {

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch

}

src_install() {

	cp yablex228.py yablex.py
	insinto /usr/lib/blender
	doins yablex.py

	dodoc readme.txt

}
