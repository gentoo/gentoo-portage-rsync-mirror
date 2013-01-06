# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnote/gnote-3.6.1.ebuild,v 1.2 2012/12/16 19:38:00 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://live.gnome.org/Gnote"

LICENSE="GPL-3+ FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

# Automagic glib-2.32 dep
COMMON_DEPEND="
	>=app-crypt/libsecret-0.8
	>=dev-cpp/glibmm-2.28:2
	>=dev-cpp/gtkmm-3.4:3.0
	>=dev-libs/boost-1.34
	>=dev-libs/glib-2.32:2
	>=dev-libs/libxml2-2:2
	dev-libs/libxslt
	>=sys-apps/util-linux-2.16:=
	>=x11-libs/gtk+-3:3
	x11-libs/libX11
"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gsettings-desktop-schemas"
DEPEND="${DEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
"

src_prepare() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable debug)
		ITSTOOL=$(type -P true)"

	# Do not alter CFLAGS
	sed 's/-DDEBUG -g/-DDEBUG/' -i configure.ac configure || die

	gnome2_src_prepare
}
