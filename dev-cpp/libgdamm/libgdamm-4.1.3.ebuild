# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libgdamm/libgdamm-4.1.3.ebuild,v 1.5 2012/05/04 03:44:59 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="C++ bindings for libgda"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="4"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="berkdb doc"

RDEPEND=">=dev-cpp/glibmm-2.27.93:2[doc?]
	>=gnome-extra/libgda-4.1.7:4[berkdb=]"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF} $(use_enable doc documentation)"
}
