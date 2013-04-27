# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnumeric/gnumeric-1.12.2.ebuild,v 1.1 2013/04/27 14:19:19 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils gnome2 flag-o-matic python-single-r1

DESCRIPTION="The GNOME Spreadsheet"
HOMEPAGE="http://projects.gnome.org/gnumeric/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE="+introspection perl python"
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
	>=x11-libs/goffice-0.10.2:0.10
	>=dev-libs/libxml2-2.4.12:2
	>=x11-libs/pango-1.24.0:=

	>=x11-libs/gtk+-3.2:3
	x11-libs/cairo:=[svg]

	introspection? ( >=dev-libs/gobject-introspection-1:= )
	perl? ( dev-lang/perl )
	python? ( ${PYTHON_DEPS}
		>=dev-python/pygobject-3:3[${PYTHON_USEDEP}] )
"
#	libgda? (
#		>=gnome-extra/libgda-4.1.1:4.0
#		>=gnome-extra/libgnomedb-3.99.6:4.0 )
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
"

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
