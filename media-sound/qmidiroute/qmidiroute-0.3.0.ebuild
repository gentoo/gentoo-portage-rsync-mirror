# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qmidiroute/qmidiroute-0.3.0.ebuild,v 1.1 2009/12/27 00:05:46 ssuominen Exp $

EAPI=2
inherit flag-o-matic multilib

DESCRIPTION="QMidiRoute is a filter/router for MIDI events"
HOMEPAGE="http://alsamodular.sourceforge.net"
SRC_URI="mirror://sourceforge/alsamodular/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	media-libs/alsa-lib"

src_configure() {
	append-ldflags -L/usr/$(get_libdir)/qt4
	econf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
