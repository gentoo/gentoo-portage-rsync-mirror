# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syscriptor/syscriptor-1.5.12.ebuild,v 1.12 2009/09/23 20:27:13 patrick Exp $

DESCRIPTION="Program that displays information about your hardware"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://syscriptor.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~alpha amd64 ppc x86"
SLOT="0"

IUSE=""

DEPEND=""

src_compile() {

	econf || die
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING CREDITS ChangeLog HISTORY LICENSE NEWS README TODO
}
