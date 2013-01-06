# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/leafpad/leafpad-0.8.18.1.ebuild,v 1.5 2012/09/13 21:14:54 ssuominen Exp $

EAPI=4
inherit eutils fdo-mime gnome2-utils

DESCRIPTION="Legacy (stable) release of the GTK+ 2.x based codebase"
HOMEPAGE="http://tarot.freeshell.org/leafpad/"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz"

LICENSE=GPL-2
SLOT=0
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=emacs

RDEPEND="virtual/libintl
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${FILESDIR}"/${P}-fdo.patch
}

src_configure() {
	econf --enable-chooser --enable-print $(use_enable emacs)
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { fdo-mime_desktop_database_update; gnome2_icon_cache_update; }
pkg_postrm() { fdo-mime_desktop_database_update; gnome2_icon_cache_update; }
