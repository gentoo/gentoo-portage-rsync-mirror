# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.28.4.ebuild,v 1.7 2012/05/05 05:38:09 jdhore Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://developer.gnome.org/libgtop/stable/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="debug doc +introspection"

RDEPEND=">=dev-libs/glib-2.6:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1.4 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} --disable-static $(use_enable introspection)"
}
