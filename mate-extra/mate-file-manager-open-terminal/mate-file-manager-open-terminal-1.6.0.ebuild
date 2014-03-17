# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-file-manager-open-terminal/mate-file-manager-open-terminal-1.6.0.ebuild,v 1.1 2014/03/17 22:17:55 tomwij Exp $

EAPI="5"

GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Caja plugin for opening terminals"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-libs/glib-2.4:2
	>=mate-base/mate-desktop-1.6:0
	>=mate-base/mate-file-manager-1.6:0
	virtual/libintl:0
	x11-libs/gtk+:2"

DEPEND="${RDEPEND}
	sys-devel/gettext:*
	>=dev-util/intltool-0.18:*
	virtual/pkgconfig:*"

src_prepare() {
	# Tarball has no proper build system, should be fixed on next release.
	eautoreconf

	gnome2_src_prepare
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
