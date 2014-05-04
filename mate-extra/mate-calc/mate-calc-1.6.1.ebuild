# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mate-extra/mate-calc/mate-calc-1.6.1.ebuild,v 1.6 2014/05/04 14:54:19 ago Exp $

EAPI="5"

GCONF_DEBUG="no"

inherit gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="A calculator application for MATE"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="app-text/rarian:0
	>=dev-libs/glib-2.30:2
	dev-libs/atk:0
	dev-libs/libxml2:2
	>=x11-libs/gtk+-2.18:2
	x11-libs/pango:0
	virtual/libintl:0"

DEPEND="${RDEPEND}
	>=app-text/mate-doc-utils-1.6
	>=app-text/scrollkeeper-dtd-1:1.0
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"

DOCS="AUTHORS ChangeLog NEWS README"
