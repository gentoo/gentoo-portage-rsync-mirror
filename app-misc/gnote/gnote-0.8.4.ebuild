# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gnote/gnote-0.8.4.ebuild,v 1.1 2012/09/18 11:07:37 tetromino Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Desktop note-taking application"
HOMEPAGE="http://live.gnome.org/Gnote"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="applet debug"

# Automagic glib-2.32 dep
COMMON_DEPEND=">=dev-libs/glib-2.32
	>=x11-libs/gtk+-3.0:3
	>=dev-cpp/glibmm-2.28:2
	>=dev-cpp/gtkmm-3.0:3.0
	>=dev-libs/libxml2-2:2
	dev-libs/libxslt
	>=dev-libs/libpcre-7.8:3[cxx]
	>=dev-libs/boost-1.34
	>=sys-apps/util-linux-2.16
	applet? ( >=gnome-base/gnome-panel-3 )"
RDEPEND="${COMMON_DEPEND}
	gnome-base/gsettings-desktop-schemas"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.35.0
	app-text/gnome-doc-utils
	app-text/docbook-xml-dtd:4.1.2"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-static
		--disable-schemas-compile
		$(use_enable applet)
		$(use_enable debug)"
}

src_prepare() {
	gnome2_src_prepare

	# Do not set idiotic defines in a released tarball, bug #311979
	sed 's/-DG.*_DISABLE_DEPRECATED//g' -i libtomboy/Makefile.* ||
		die "sed failed"
}
