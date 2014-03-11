# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mate-themes/mate-themes-1.6.3.ebuild,v 1.1 2014/03/11 01:57:34 tomwij Exp $

EAPI="5"

GCONF_DEBUG="no"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A set of MATE themes, with sets for users with limited or low vision"
HOMEPAGE="http://mate-desktop.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=x11-libs/gdk-pixbuf-2:2
	>=x11-libs/gtk+-2:2
	>=x11-themes/gtk-engines-2.15.3:2
	x11-themes/murrine-themes:0"

DEPEND="${RDEPEND}
	>=app-text/mate-doc-utils-1.6:0
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	>=x11-misc/icon-naming-utils-0.8.7:0
	virtual/pkgconfig:*"

RESTRICT="binchecks strip"

src_configure() {
	gnome2_src_configure \
		--disable-test-themes \
		--enable-icon-mapping
}

DOCS="AUTHORS ChangeLog NEWS README"
