# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.34.2.ebuild,v 1.16 2012/05/05 05:38:09 jdhore Exp $

EAPI="4"
GNOME2_LA_PUNT="yes"
GCONF_DEBUG="no"
PYTHON_DEPEND="2"

inherit gnome2 multilib eutils autotools python

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="http://librsvg.sourceforge.net/"
SRC_URI="${SRC_URI} mirror://gentoo/introspection.m4.bz2"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="doc +gtk gtk3 +introspection tools"

RDEPEND=">=media-libs/fontconfig-1.0.1
	>=media-libs/freetype-2
	>=dev-libs/glib-2.24:2
	>=x11-libs/cairo-1.2
	>=x11-libs/pango-1.10
	>=dev-libs/libxml2-2.4.7:2
	>=dev-libs/libcroco-0.6.1
	x11-libs/gdk-pixbuf:2[introspection?]
	gtk? ( >=x11-libs/gtk+-2.16:2 )
	gtk3? ( >=x11-libs/gtk+-2.90.0:3 )
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.13 )

	>=dev-util/gtk-doc-am-1.13"
# >=dev-util/gtk-doc-am-1.13 and gobject-introspection needed by eautoreconf

pkg_setup() {
	# croco is forced on to respect SVG specification
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable tools)
		$(use_enable gtk gtk-theme)
		$(use_enable introspection)
		--with-croco
		--enable-pixbuf-loader"
	use gtk && ! use gtk3 && G2CONF+=" --with-gtk=2.0"
	use gtk && use gtk3 && G2CONF+=" --with-gtk=both"
	! use gtk && use gtk3 && G2CONF+=" --with-gtk=3.0 --enable-gtk-theme"

	DOCS="AUTHORS ChangeLog README NEWS TODO"

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Fix automagic gtk+ dependency, bug #371290
	epatch "${FILESDIR}/${PN}-2.34.0-automagic-gtk.patch"

	# bug #391215, https://bugzilla.gnome.org/show_bug.cgi?id=664684
	epatch "${FILESDIR}/${PN}-2.34.2-gir-filename.patch"

	# introspection.m4 needed for eautoreconf
	mv "${WORKDIR}/introspection.m4" "${S}"/ || die

	AT_M4DIR="." eautoreconf

	python_convert_shebangs -r 2 .

	gnome2_src_prepare
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
