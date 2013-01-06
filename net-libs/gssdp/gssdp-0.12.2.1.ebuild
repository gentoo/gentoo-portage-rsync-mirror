# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gssdp/gssdp-0.12.2.1.ebuild,v 1.8 2012/10/28 16:23:09 armin76 Exp $

EAPI=4

inherit eutils gnome.org multilib

DESCRIPTION="A GObject-based API for handling resource discovery and announcement over SSDP."
HOMEPAGE="http://gupnp.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="+introspection +gtk"

RDEPEND=">=dev-libs/glib-2.22:2
	>=net-libs/libsoup-2.26.1:2.4[introspection?]
	gtk? ( >=x11-libs/gtk+-2.12:2 )
	introspection? (
		>=dev-libs/gobject-introspection-0.6.7
		dev-lang/vala:0.14[vapigen]
	)
	!<net-libs/gupnp-vala-0.10.3
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/gettext"

src_prepare() {
	# Disable functional test as it requires port that might be used by rygel to
	# be free of use
	sed 's/\(check_PROGRAMS.*\)test-functional$(EXEEXT)/\1/' \
		-i "${S}"/tests/gtest/Makefile.in || die
}

src_configure() {
	econf \
		$(use_enable introspection) \
		$(use_with gtk) \
		--disable-dependency-tracking \
		--disable-static \
		--disable-gtk-doc \
		VAPIGEN="$(type -P vapigen-0.14)"
}

src_install() {
	default
	# Remove pointless .la files
	find "${D}" -name '*.la' -delete
}

pkg_preinst() {
	preserve_old_lib /usr/$(get_libdir)/libgssdp-1.0.so.2
}

pkg_postinst() {
	preserve_old_lib_notify /usr/$(get_libdir)/libgssdp-1.0.so.2
}
