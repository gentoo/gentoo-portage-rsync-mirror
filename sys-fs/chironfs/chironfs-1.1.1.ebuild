# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/chironfs/chironfs-1.1.1.ebuild,v 1.3 2009/12/21 14:30:19 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Chiron FS - A FUSE based replication filesystem"
HOMEPAGE="http://www.furquim.org/chironfs/"
SRC_URI="http://chironfs.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-fs/fuse"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	mv "${D}"/usr/share/doc/${PN} "${D}"/usr/share/doc/${P}
}
