# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-ews/evolution-ews-3.4.4.ebuild,v 1.2 2012/12/24 04:41:51 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit db-use eutils flag-o-matic gnome2 versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Evolution module for connecting to Microsoft Exchange Web Services"
HOMEPAGE="http://www.gnome.org/projects/evolution/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="" # doc

RDEPEND=">=mail-client/evolution-${PV}:2.0
	>=gnome-extra/evolution-data-server-${PV}
	=gnome-extra/evolution-data-server-${MY_MAJORV}*
	>=dev-libs/glib-2.26:2
	>=dev-libs/libxml2-2
	>=gnome-base/gconf-2:2
	>=net-libs/libsoup-2.30:2.4
	>=x11-libs/gtk+-2.90.4:3
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	virtual/pkgconfig
"
# For now, this package has no gtk-doc documentation to build
#	doc? ( >=dev-util/gtk-doc-1.9 )

RESTRICT="test" # tests require connecting to an Exchange server

pkg_setup() {
	DOCS="ChangeLog NEWS README" # AUTHORS is empty
}
