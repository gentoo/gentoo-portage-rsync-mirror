# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mousepad/mousepad-0.3.0.ebuild,v 1.1 2012/12/30 11:29:37 ssuominen Exp $

EAPI=5
inherit xfconf

DESCRIPTION="GTK+ 2.x based editor for the Xfce Desktop Environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/start"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug dbus"

RDEPEND=">=dev-libs/glib-2.12
	>=x11-libs/gtk+-2.20:2
	x11-libs/gtksourceview:2.0
	dbus? ( >=dev-libs/dbus-glib-0.100 )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-validate.patch )

	XFCONF=(
		$(xfconf_use_debug)
		$(use_enable dbus)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
