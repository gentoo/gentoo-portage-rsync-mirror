# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/librsvg/librsvg-2.40.2.ebuild,v 1.4 2014/05/04 12:10:30 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit autotools gnome2 vala

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="+introspection vala tools"
REQUIRED_USE="
	vala? ( introspection )
"

RDEPEND="
	>=dev-libs/glib-2.24:2
	>=x11-libs/cairo-1.2
	>=x11-libs/pango-1.32.6
	>=dev-libs/libxml2-2.7:2
	>=dev-libs/libcroco-0.6.1
	>=x11-libs/gdk-pixbuf-2.20:2[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.10.8 )
	tools? ( >=x11-libs/gtk+-3.2.0:3 )
"
DEPEND="${RDEPEND}
	dev-libs/gobject-introspection-common
	dev-libs/vala-common
	>=dev-util/gtk-doc-am-1.13
	virtual/pkgconfig
	vala? ( $(vala_depend) )
"
# >=gtk-doc-am-1.13, gobject-introspection-common, vala-common needed by eautoreconf

src_prepare() {
	# https://bugzilla.gnome.org/show_bug.cgi?id=712693
	epatch "${FILESDIR}/${PN}-2.40.1-gtk-optional.patch"
	eautoreconf

	use vala && vala_src_prepare
	gnome2_src_prepare
}

src_configure() {
	local myconf=""

	# -Bsymbolic is not supported by the Darwin toolchain
	if [[ ${CHOST} == *-darwin* ]]; then
		myconf="${myconf} --disable-Bsymbolic"
	fi

	# --disable-tools even when USE=tools; the tools/ subdirectory is useful
	# only for librsvg developers
	gnome2_src_configure \
		--disable-static \
		--disable-tools \
		$(use_enable introspection) \
		$(use_with tools gtk3) \
		$(use_enable vala) \
		--enable-pixbuf-loader \
		${myconf}
}

src_compile() {
	# causes segfault if set, see bug #411765
	unset __GL_NO_DSO_FINALIZER
	gnome2_src_compile
}

pkg_postinst() {
	# causes segfault if set, see bug 375615
	unset __GL_NO_DSO_FINALIZER
	gnome2_pkg_postinst
}

pkg_postrm() {
	# causes segfault if set, see bug 375615
	unset __GL_NO_DSO_FINALIZER
	gnome2_pkg_postrm
}
