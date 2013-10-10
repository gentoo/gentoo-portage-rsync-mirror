# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.12.8.ebuild,v 1.1 2013/10/10 19:03:31 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils gnome2 flag-o-matic python-single-r1

DESCRIPTION="The GNOME Spreadsheet"
HOMEPAGE="http://projects.gnome.org/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="+introspection libgda perl python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# Missing gnome-extra/libgnomedb required version in tree
# but its upstream is dead and will be dropped soon.

# lots of missing files, wait for next release
# also fails tests due to 80-bit long story
RESTRICT="test"

RDEPEND="
	app-arch/bzip2
	sys-libs/zlib
	>=dev-libs/glib-2.28:2
	>=gnome-extra/libgsf-1.14.24:=
	>=x11-libs/goffice-0.10.3:0.10
	>=dev-libs/libxml2-2.4.12:2
	>=x11-libs/pango-1.24.0:=

	>=x11-libs/gtk+-3.2:3
	x11-libs/cairo:=[svg]

	introspection? ( >=dev-libs/gobject-introspection-1:= )
	perl? ( dev-lang/perl )
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-3:3[${PYTHON_USEDEP}] )
	libgda? ( gnome-extra/libgda:5[gtk] )
"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--with-zlib \
		$(use_with libgda gda) \
		$(use_enable introspection) \
		$(use_with perl) \
		$(use_with python)
}
