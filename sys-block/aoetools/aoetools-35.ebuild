# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/aoetools/aoetools-35.ebuild,v 1.1 2012/10/27 04:23:43 radhermit Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="tools for ATA over Ethernet (AoE) network storage protocol"
HOMEPAGE="http://aoetools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DOCS="NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-32-build.patch
	tc-export CC
}
