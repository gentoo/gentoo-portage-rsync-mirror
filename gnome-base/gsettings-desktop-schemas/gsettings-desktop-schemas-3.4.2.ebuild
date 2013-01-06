# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gsettings-desktop-schemas/gsettings-desktop-schemas-3.4.2.ebuild,v 1.12 2012/10/28 15:51:03 armin76 Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Collection of GSettings schemas for GNOME desktop"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE="+introspection"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x64-macos ~sparc-solaris ~x86-solaris"

RDEPEND=">=dev-libs/glib-2.31:2
	introspection? ( >=dev-libs/gobject-introspection-1.31.0 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable introspection)"
	DOCS="AUTHORS HACKING NEWS README"
}
