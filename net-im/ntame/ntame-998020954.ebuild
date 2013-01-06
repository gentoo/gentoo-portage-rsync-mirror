# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ntame/ntame-998020954.ebuild,v 1.8 2007/05/06 11:50:25 genone Exp $

S=${WORKDIR}/ntaim
DESCRIPTION="Ncurses based AOL Instant Messenger"
HOMEPAGE="http://tame.sourceforge.net/"
SRC_URI="mirror://sourceforge/tame/ntaim.${PV}.tar.gz"
DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

src_compile () {

	./configure --prefix=/usr --host=${CHOST} || die
	emake || die

}

src_install () {

	dodir /usr/bin
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS NEWS README TODO
}

pkg_postinst () {
	elog "Executable name is actually ntaim"
}
