# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-groupwise/evolution-groupwise-3.4.2.ebuild,v 1.2 2012/12/24 04:49:56 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit db-use eutils flag-o-matic gnome2 versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Evolution module for connecting to Novell Groupwise"
HOMEPAGE="http://www.gnome.org/projects/evolution/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="" # doc

RDEPEND=">=mail-client/evolution-${PV}:2.0
	>=gnome-extra/evolution-data-server-${PV}
	=gnome-extra/evolution-data-server-${MY_MAJORV}*
	>=dev-libs/glib-2.16
	>=dev-libs/libxml2-2
	>=gnome-base/gconf-2:2
	gnome-extra/gtkhtml:4.0
	>=net-libs/libsoup-2.3:2.4
	sys-libs/db
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.90.4:3
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	virtual/pkgconfig
"
# For now, this package has no gtk-doc documentation to build
#	doc? ( >=dev-util/gtk-doc-1.9 )

pkg_setup() {
	DOCS="ChangeLog NEWS" # AUTHORS, README are empty
}

src_prepare() {
	# /usr/include/db.h is always db-1 on FreeBSD
	# so include the right dir in CPPFLAGS
	append-cppflags "-I$(db_includedir)"

	gnome2_src_prepare
}
