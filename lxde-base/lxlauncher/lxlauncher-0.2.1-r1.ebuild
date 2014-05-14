# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxlauncher/lxlauncher-0.2.1-r1.ebuild,v 1.4 2014/05/14 18:16:24 tomwij Exp $

EAPI="5"

inherit autotools eutils

DESCRIPTION="An open source clone of the Asus launcher for EeePC"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="dev-libs/glib:2
	gnome-base/gnome-menus
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/startup-notification"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	lxde-base/menu-cache
	!lxde-base/lxlauncher-gmenu"

src_prepare() {
	epatch "${FILESDIR}"/${P}-intltool.patch
	epatch "${FILESDIR}"/${P}-fix-segfault.patch

	# Rerun autotools
	einfo "Regenerating autotools files..."
	eautoreconf

	# Support as-needed and add missing libraries.
	sed -e 's/^\(LINK = .*\) -o $@$/\1/' \
		-e 's/$(lxlauncher_OBJECTS) $(lxlauncher_LDADD) $(LIBS)/\0 -lX11 -o $@/' \
		-i src/Makefile.in || die
}
