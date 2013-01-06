# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.12.0-r1.ebuild,v 1.1 2012/12/29 09:37:46 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils gnome2 flag-o-matic python-single-r1

DESCRIPTION="The GNOME Spreadsheet"
HOMEPAGE="http://projects.gnome.org/gnumeric/"
LICENSE="GPL-2"
SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${PN}-1.12.0-annotation-syntax.patch.xz"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="+introspection perl python"
# Missing gnome-extra/libgnomedb required version in tree
# but its upstream is dead and will be dropped soon.

# lots of missing files, wait for next release
# also fails tests due to 80-bit long story
RESTRICT="test"

RDEPEND="sys-libs/zlib
	app-arch/bzip2
	>=dev-libs/glib-2.28.0:2
	>=gnome-extra/libgsf-1.14.24:=
	>=x11-libs/goffice-0.10.0:0.10
	>=dev-libs/libxml2-2.4.12:2
	>=x11-libs/pango-1.24.0:=

	>=x11-libs/gtk+-3.0.0:3
	x11-libs/cairo:=[svg]

	introspection? ( >=dev-libs/gobject-introspection-1.0.0:= )
	perl? ( dev-lang/perl )
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-3.0.0:3[${PYTHON_USEDEP}] )
"
#	libgda? (
#		>=gnome-extra/libgda-4.1.1:4.0
#		>=gnome-extra/libgnomedb-3.99.6:4.0 )
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	app-text/scrollkeeper"

src_prepare() {
	# Fix gtk-doc annotation syntax for gobject-introspection-1.34; bug #448992
	# https://bugzilla.gnome.org/show_bug.cgi?id=684159
	epatch "../${PN}-1.12.0-annotation-syntax.patch"
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--enable-ssindex \
		--disable-static \
		--without-gda \
		--with-zlib \
		$(use_enable introspection) \
		$(use_with perl) \
		$(use_with python)
}
