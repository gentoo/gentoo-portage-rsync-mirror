# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kf/kf-0.1.3.ebuild,v 1.7 2011/03/02 21:03:56 signals Exp $

EAPI=2

DESCRIPTION="kf is a simple Jabber messenger."
HOMEPAGE="http://www.habazie.rams.pl/kf/"
SRC_URI="http://www.habazie.rams.pl/kf/files/${P}.tar.gz"
LICENSE="GPL-2"
DEPEND="x11-libs/gtk+:2
	>=net-libs/loudmouth-0.15.1
	>=gnome-base/libglade-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc"

src_install() {
	make install DESTDIR="${D}" || die 'make install failed'
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
