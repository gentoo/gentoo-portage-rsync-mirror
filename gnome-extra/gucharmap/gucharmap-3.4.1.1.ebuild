# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gucharmap/gucharmap-3.4.1.1.ebuild,v 1.9 2012/11/15 19:51:04 pacho Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Unicode character map viewer and library"
HOMEPAGE="https://live.gnome.org/Gucharmap"

LICENSE="GPL-3"
SLOT="2.90"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="cjk doc +introspection test"

COMMON_DEPEND=">=dev-libs/glib-2.25.3
	>=x11-libs/pango-1.2.1[introspection?]
	>=x11-libs/gtk+-3.0.0:3[introspection?]

	introspection? ( >=dev-libs/gobject-introspection-0.9.0 )"
RDEPEND="${COMMON_DEPEND}
	!<gnome-extra/gucharmap-3:0"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	virtual/pkgconfig
	>=dev-util/intltool-0.40
	>=app-text/gnome-doc-utils-0.9.0

	sys-devel/gettext

	doc? ( >=dev-util/gtk-doc-1.0 )
	test? ( ~app-text/docbook-xml-dtd-4.1.2 )"

src_prepare() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable introspection)
		$(use_enable cjk unihan)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"

	# prevent file collisions with slot 0
	sed -e "s:GETTEXT_PACKAGE=gucharmap$:GETTEXT_PACKAGE=gucharmap-${SLOT}:" \
		-i configure.ac configure || die "sed configure.ac configure failed"

	epatch "${FILESDIR}/${P}-fix-doc.patch" # bug 436710, fixed in 3.6

	gnome2_src_prepare

	# avoid autoreconf
	sed -e 's/-Wall //g' -i configure || die "sed failed"
}
