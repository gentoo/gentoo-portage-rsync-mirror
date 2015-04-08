# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/gtkpbbuttons/gtkpbbuttons-0.6.10.ebuild,v 1.4 2011/03/27 11:41:56 nirbheek Exp $

EAPI="1"

inherit eutils

DESCRIPTION="On screen display client for pbbuttonsd"
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="mirror://sourceforge/pbbuttons/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ~x86"
IUSE="gnome"

DEPEND="x11-libs/gtk+:2
	>=media-libs/audiofile-0.1.9
	dev-libs/popt
	>=app-laptop/pbbuttonsd-0.7.9
	gnome? ( gnome-base/libgnomeui )"

src_compile() {
	local myconf=""
	use gnome && myconf="--with-gnome"
	econf ${myconf}
	make || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README
}
