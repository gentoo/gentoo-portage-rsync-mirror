# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/davl/davl-1.2.4.ebuild,v 1.1 2012/01/14 18:24:19 armin76 Exp $

EAPI=1
inherit eutils

DESCRIPTION="Visualizes the fragmentation status of ext2/3 filesystems"
HOMEPAGE="http://davl.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6:2"
DEPEND="${RDEPEND}
>=sys-fs/e2fsprogs-1.38"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.2.1-asneeded.patch
}

src_install() {
	dobin src/cdavl/cdavl src/gdavl/gdavl
	dodoc README
	doman doc/*.8
}
