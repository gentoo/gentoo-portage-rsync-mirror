# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/screen-message/screen-message-0.22.ebuild,v 1.1 2014/05/29 16:30:21 sping Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Display a multi-line message large, fullscreen, black on white"
HOMEPAGE="http://www.joachim-breitner.de/projects#screen-message"
SRC_URI="mirror://debian/pool/main/s/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/gtk+:3
	>=x11-libs/pango-1.16"
RDEPEND="${DEPEND}
	!<net-im/jabberd2-2.2.17-r1"

src_prepare() {
	epatch "${FILESDIR}"/${P}-desktop-file.patch
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodir /usr/bin || die
	mv "${D}"/usr/{games,bin}/sm || die
	sed -i 's|Exec=/usr/games/sm||' "${D}"/usr/share/applications/sm.desktop || die
}
