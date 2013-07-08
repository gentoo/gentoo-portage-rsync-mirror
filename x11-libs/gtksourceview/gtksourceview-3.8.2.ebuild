# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtksourceview/gtksourceview-3.8.2.ebuild,v 1.1 2013/07/08 17:29:45 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 virtualx

DESCRIPTION="A text widget implementing syntax highlighting and other features"
HOMEPAGE="http://projects.gnome.org/gtksourceview/"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="3.0/1"
IUSE="glade +introspection"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-solaris"

# Note: has native OSX support, prefix teams, attack!
RDEPEND="
	>=x11-libs/gtk+-3.7.12:3[introspection?]
	>=dev-libs/libxml2-2.6:2
	>=dev-libs/glib-2.34.0:2
	glade? ( >=dev-util/glade-3.9:3.10 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/intltool-0.50
	>=sys-devel/gettext-0.17
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure \
		--disable-deprecations \
		--enable-providers \
		$(use_enable glade glade-catalog) \
		$(use_enable introspection)
}

src_test() {
	Xemake check
}

src_install() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README"
	gnome2_src_install

	insinto /usr/share/${PN}-3.0/language-specs
	doins "${FILESDIR}"/2.0/gentoo.lang
}
