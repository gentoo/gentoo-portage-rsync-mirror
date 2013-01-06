# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/worker/worker-2.18.1.ebuild,v 1.5 2012/09/30 18:00:37 armin76 Exp $

inherit eutils

DESCRIPTION="Worker Filemanager: Amiga Directory Opus 4 clone"
HOMEPAGE="http://www.boomerangsworld.de/worker/"
SRC_URI="http://www.boomerangsworld.de/worker/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ~ppc64 x86"
IUSE="avfs"

RDEPEND="x11-libs/libSM
	dev-libs/dbus-glib
	avfs? ( sys-fs/avfs )"
DEPEND="${RDEPEND}"

src_compile() {
	econf \
		$(use_with avfs) || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die "make install failed"
	doman man/worker.1
	dodoc AUTHORS ChangeLog INSTALL NEWS README README_LARGEFILES THANKS
	make_desktop_entry ${PN} Worker WorkerIcon "System;Utility"
}
