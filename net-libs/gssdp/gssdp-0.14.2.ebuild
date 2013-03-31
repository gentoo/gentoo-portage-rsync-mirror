# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gssdp/gssdp-0.14.2.ebuild,v 1.2 2013/03/30 23:25:32 eva Exp $

EAPI="5"
VALA_MIN_API_VERSION="0.14"
VALA_USE_DEPEND="vapigen"

inherit eutils gnome.org multilib vala

DESCRIPTION="A GObject-based API for handling resource discovery and announcement over SSDP."
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0/3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="+introspection +gtk"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=net-libs/libsoup-2.26.1:2.4[introspection?]
	gtk? ( >=x11-libs/gtk+-2.12:2 )
	introspection? (
		>=dev-libs/gobject-introspection-0.6.7
		$(vala_depend)
	)
	!<net-libs/gupnp-vala-0.10.3
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.10
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	# Disable functional test as it requires port that might be used by rygel to
	# be free of use
	sed 's/\(check_PROGRAMS.*\)test-functional$(EXEEXT)/\1/' \
		-i "${S}"/tests/gtest/Makefile.in || die
	use introspection && vala_src_prepare
}

src_configure() {
	econf \
		$(use_enable introspection) \
		$(use_with gtk) \
		--disable-static \
		--disable-gtk-doc
}

src_install() {
	default
	prune_libtool_files
}
