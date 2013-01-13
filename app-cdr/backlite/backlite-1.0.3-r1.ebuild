# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/backlite/backlite-1.0.3-r1.ebuild,v 1.2 2013/01/13 11:12:46 ago Exp $

EAPI=4

inherit qt4-r2

DESCRIPTION="backlite is a pure QT4 version of k9copy"
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/k9copy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="mplayer"

# According to the author of backlite/k9copy libdvdread and libdvdnav are
# bundled internal because newer versions produce bad DVD copies.
# This will be fixed later.
# DEPEND="media-libs/libdvdread"

DEPEND=">=media-libs/libmpeg2-0.5.1
	virtual/ffmpeg
	x11-libs/qt-gui:4[dbus]
	|| ( x11-libs/qt-phonon:4 media-libs/phonon )"

RDEPEND="${DEPEND}
	media-video/dvdauthor
	mplayer? ( media-video/mplayer )"

src_prepare() {
	sed -i -e '/^MimeTypes=.*/d' \
		-e '/^Encoding=.*/d' *.desktop || die
}

src_configure() {
	eqmake4 backlite.pro PREFIX="${D}"/usr
}

src_install() {
	unset INSTALL_ROOT
	default
}
