# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.36.4.ebuild,v 1.12 2013/04/01 18:24:42 ago Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit autotools eutils gnome2 multilib vala

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://live.gnome.org/LibRsvg"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="+gtk +introspection tools vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND=">=dev-libs/glib-2.24:2
	>=x11-libs/cairo-1.2
	>=x11-libs/pango-1.16
	>=dev-libs/libxml2-2.7:2
	>=dev-libs/libcroco-0.6.1
	x11-libs/gdk-pixbuf:2[introspection?]
	gtk? (
		>=x11-libs/gtk+-2.16:2
		tools? ( >=x11-libs/gtk+-3:3 ) )
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-libs/gobject-introspection-common
	dev-libs/vala-common
	>=dev-util/gtk-doc-am-1.13
	vala? ( $(vala_depend) )"
# >=gtk-doc-am-1.13, gobject-introspection-common, vala-common needed by eautoreconf

src_prepare() {
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable tools)
		$(use_enable gtk gtk-theme)
		$(use_enable introspection)
		$(use_enable vala)
		--enable-pixbuf-loader"
	if use gtk && use tools; then
		G2CONF="${G2CONF} --enable-rsvg-view"
	else
		G2CONF="${G2CONF} --disable-rsvg-view"
	fi
	# -Bsymbolic is not supported by the Darwin toolchain
	[[ ${CHOST} == *-darwin* ]] && G2CONF="${G2CONF} --disable-Bsymbolic"

	DOCS="AUTHORS ChangeLog README NEWS TODO"

	# Make rsvg-view non-automagic
	epatch "${FILESDIR}/${PN}-2.36.0-rsvg-view-automagic.patch"

	use vala && vala_src_prepare

	eautoreconf
	gnome2_src_prepare
}

src_compile() {
	# causes segfault if set, see bug #411765
	unset __GL_NO_DSO_FINALIZER
	gnome2_src_compile
}

pkg_postinst() {
	# causes segfault if set, see bug 375615
	unset __GL_NO_DSO_FINALIZER

	tmp_file=$(mktemp -t tmp.XXXXXXXXXXlibrsvg_ebuild)
	# be atomic!
	gdk-pixbuf-query-loaders > "${tmp_file}"
	if [ "${?}" = "0" ]; then
		cat "${tmp_file}" > "${EROOT}usr/$(get_libdir)/gdk-pixbuf-2.0/2.10.0/loaders.cache"
	else
		ewarn "Cannot update loaders.cache, gdk-pixbuf-query-loaders failed to run"
	fi
	rm "${tmp_file}"
}

pkg_postrm() {
	# causes segfault if set, see bug 375615
	unset __GL_NO_DSO_FINALIZER

	tmp_file=$(mktemp -t tmp.XXXXXXXXXXlibrsvg_ebuild)
	# be atomic!
	gdk-pixbuf-query-loaders > "${tmp_file}"
	if [ "${?}" = "0" ]; then
		cat "${tmp_file}" > "${EROOT}usr/$(get_libdir)/gdk-pixbuf-2.0/2.10.0/loaders.cache"
	else
		ewarn "Cannot update loaders.cache, gdk-pixbuf-query-loaders failed to run"
	fi
	rm "${tmp_file}"
}
