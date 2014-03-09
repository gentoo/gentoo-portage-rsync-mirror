# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-calc/mate-calc-1.6.1.ebuild,v 1.1 2014/03/09 15:04:58 tomwij Exp $

EAPI="5"

GCONF_DEBUG="no"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A calculator application for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=dev-libs/glib-2.30:2
	dev-libs/atk:0
	dev-libs/libxml2:2
	>=x11-libs/gtk+-2.18:2
	x11-libs/pango:0
	virtual/libintl:0"

DEPEND="${RDEPEND}
	>=app-text/mate-doc-utils-1.6
	app-text/scrollkeeper:0
	>=dev-util/intltool-0.35:0
	sys-devel/gettext:0
	sys-libs/glibc:2.2
	virtual/pkgconfig:0"

DOCS="AUTHORS ChangeLog NEWS README"
