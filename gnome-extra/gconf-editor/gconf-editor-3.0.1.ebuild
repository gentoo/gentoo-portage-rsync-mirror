# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gconf-editor/gconf-editor-3.0.1.ebuild,v 1.2 2012/05/05 06:25:22 jdhore Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="An editor to the GNOME 2 config system"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE=""

RDEPEND=">=x11-libs/gtk+-3.0.0:3
	>=gnome-base/gconf-2.12:2"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	sys-devel/gettext
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	~app-text/docbook-xml-dtd-4.1.2"
# gnome-common for eautoreconf

pkg_setup() {
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
	G2CONF="${G2CONF}
		--disable-maintainer-mode
		--disable-scrollkeeper"
}
