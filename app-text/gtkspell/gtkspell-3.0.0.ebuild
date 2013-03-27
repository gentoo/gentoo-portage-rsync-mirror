# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-3.0.0.ebuild,v 1.6 2013/03/27 09:40:30 ago Exp $

EAPI="5"

inherit eutils

DESCRIPTION="Spell checking widget for GTK"
HOMEPAGE="http://gtkspell.sourceforge.net/"
MY_P="${PN}3-${PV}"
SRC_URI="mirror://sourceforge/project/${PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2+"
SLOT="3/0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="+introspection"

RDEPEND=">=app-text/enchant-1.1.6
	dev-libs/glib:2
	x11-libs/gtk+:3[introspection?]
	>=x11-libs/pango-1.8.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-1.30 )"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.17
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}"

src_configure() {
	econf \
		--disable-static \
		$(use_enable introspection)
}

src_install() {
	default
	prune_libtool_files
}
