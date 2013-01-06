# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/pangomm/pangomm-2.28.4.ebuild,v 1.9 2012/05/04 03:44:56 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="C++ interface for pango"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="1.4"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~x86-solaris"
IUSE="doc"

COMMON_DEPEND=">=x11-libs/pango-1.23.0
	>=dev-cpp/glibmm-2.14.1:2
	>=dev-cpp/cairomm-1.2.2
	dev-libs/libsigc++:2
"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	doc? (
		media-gfx/graphviz
		dev-libs/libxslt
		app-doc/doxygen )
"
RDEPEND="${COMMON_DEPEND}
	!<dev-cpp/gtkmm-2.13:2.4"

src_prepare() {
	G2CONF="${G2CONF}
		$(use_enable doc documentation)"
	DOCS="AUTHORS ChangeLog NEWS README*"
}
