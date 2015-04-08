# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/matchbox-desktop/matchbox-desktop-0.9.1.ebuild,v 1.9 2012/06/04 00:31:01 xmw Exp $

inherit versionator

DESCRIPTION="The Matchbox Desktop"
HOMEPAGE="http://matchbox-project.org/"
SRC_URI="http://matchbox-project.org/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~arm ~hppa ppc x86"
IUSE="debug dnotify startup-notification"

DEPEND=">=x11-libs/libmatchbox-1.5
	startup-notification? ( x11-libs/startup-notification )"

RDEPEND="${DEPEND}
	x11-wm/matchbox-common"

src_compile() {
	econf	$(use_enable debug) \
		$(use_enable startup-notification) \
		$(use_enable dnotify) \
		|| die "Configuration failed"

	emake || die "Compilation failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Installation failed"

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
