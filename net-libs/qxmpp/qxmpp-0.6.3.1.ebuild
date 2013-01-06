# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/qxmpp/qxmpp-0.6.3.1.ebuild,v 1.1 2012/08/13 13:12:42 maksbotan Exp $

EAPI=3

inherit multilib qt4-r2

DESCRIPTION="A cross-platform C++ XMPP client library based on the Qt framework."
HOMEPAGE="http://code.google.com/p/qxmpp/"
SRC_URI="mirror://github/0xd34df00d/qxmpp-dev/${P}-extras.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +extras"

DEPEND="x11-libs/qt-core:4
		x11-libs/qt-gui:4
		media-libs/speex"
RDEPEND="${DEPEND}"

src_prepare() {
	#Disable silly debug library '_d' suffix
	sed -e 's/qxmpp-lc_d/qxmpp-lc/' -i qxmpp.pri || die "sed faild"
	qt4-r2_src_prepare
}

src_configure(){
	eqmake4 "${S}"/qxmpp.pro "PREFIX=/usr" "LIBDIR=$(get_libdir)"
}
