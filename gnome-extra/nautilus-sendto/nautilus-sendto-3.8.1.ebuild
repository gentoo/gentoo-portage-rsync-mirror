# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-3.8.1.ebuild,v 1.2 2013/11/30 19:26:33 pacho Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="A nautilus extension for sending files to locations"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="+introspection"

RDEPEND="
	>=x11-libs/gtk+-2.90.3:3[X(+)]
	introspection? ( >=dev-libs/gobject-introspection-0.6.7 )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
"
# Needed for eautoreconf
#	>=gnome-base/gnome-common-0.12
