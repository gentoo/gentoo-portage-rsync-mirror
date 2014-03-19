# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mate-netspeed/mate-netspeed-1.6.1.ebuild,v 1.1 2014/03/19 16:41:51 tomwij Exp $

EAPI="5"

GCONF_DEBUG="no"

inherit autotools gnome2 versionator

MATE_BRANCH="$(get_version_component_range 1-2)"

SRC_URI="http://pub.mate-desktop.org/releases/${MATE_BRANCH}/${P}.tar.xz"
DESCRIPTION="Applet showing network traffic for MATE"
HOMEPAGE="http://mate-desktop.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64"

# FIXME: wireless-tools >= 28pre9 is automagic
RDEPEND="dev-libs/glib:2
	>=gnome-base/libgtop-2.14.2:2
	>=mate-base/mate-panel-1.6:0
	>=net-wireless/wireless-tools-28_pre9:0
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/pango:0
	virtual/libintl:0"

DEPEND="${RDEPEND}
	>=app-text/gnome-doc-utils-0.3.2:0
	>=dev-util/intltool-0.35:*
	sys-devel/gettext:*
	virtual/pkgconfig:*"

DOCS="AUTHORS ChangeLog README"

src_prepare() {
	# Tarball has no proper build system, should be fixed on next release.
	eautoreconf

	gnome2_src_prepare
}
