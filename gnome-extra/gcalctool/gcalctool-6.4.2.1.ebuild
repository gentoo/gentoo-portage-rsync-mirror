# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gcalctool/gcalctool-6.4.2.1.ebuild,v 1.1 2012/05/24 09:22:18 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="A calculator application for GNOME"
HOMEPAGE="http://live.gnome.org/Gcalctool http://calctool.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"

COMMON_DEPEND=">=x11-libs/gtk+-3:3
	>=dev-libs/glib-2.31:2
	dev-libs/libxml2"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/gnome-utils-2.3"
DEPEND="${COMMON_DEPEND}
	>=app-text/gnome-doc-utils-0.3.2
	app-text/scrollkeeper
	>=dev-util/intltool-0.35
	sys-devel/bison
	sys-devel/flex
	sys-devel/gettext
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-schemas-compile
		ITSTOOL=$(type -P true)"
	DOCS="AUTHORS ChangeLog* NEWS README"
}
