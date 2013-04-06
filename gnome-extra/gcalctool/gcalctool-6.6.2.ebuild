# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcalctool/gcalctool-6.6.2.ebuild,v 1.2 2013/04/06 09:32:46 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A calculator application for GNOME"
HOMEPAGE="http://live.gnome.org/Gcalctool http://calctool.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

COMMON_DEPEND="
	>=x11-libs/gtk+-3:3
	>=dev-libs/glib-2.31:2
	dev-libs/libxml2:2
"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/gnome-utils-2.3"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
	!gnome-extra/gnome-calculator
"

src_configure() {
	DOCS="AUTHORS ChangeLog* NEWS README"
	G2CONF="${G2CONF} ITSTOOL=$(type -P true)"
	gnome2_src_configure
}
