# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-2.32.0.ebuild,v 1.12 2012/12/17 10:08:13 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2 python toolchain-funcs

DESCRIPTION="An API documentation browser for GNOME"
HOMEPAGE="http://live.gnome.org/devhelp"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc sparc x86 ~x86-fbsd"
IUSE=""

COMMON_DEPEND=">=gnome-base/gconf-2.6:2
	>=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2.10:2
	>=x11-libs/libwnck-2.10:1
	>=net-libs/webkit-gtk-1.1.13:2
	>=dev-libs/libunique-1:1"
# libgnome is needed for /desktop/gnome/interface/* gconf keys
RDEPEND="${COMMON_DEPEND}
	gnome-base/libgnome"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.40
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	# ICC is crazy, silence warnings (bug #154010)
	if [[ $(tc-getCC) == "icc" ]] ; then
		G2CONF="${G2CONF} --with-compile-warnings=no"
	fi
	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	echo '#!/bin/sh' > py-compile

	# Fix build with older libunique, bug #286890
	sed -e 's/-DG.*_SINGLE_INCLUDES//' \
		-e 's/-DG.*_DEPRECATED//' \
		-i src/Makefile.am src/Makefile.in || die "sed 2 failed"

	# Fix gconf schema
	epatch "${FILESDIR}/${PN}-2.32.0-fix-schema.patch"
}

src_install() {
	gnome2_src_install
	# Internal library, punt .la file
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"
}

pkg_preinst() {
	gnome2_pkg_preinst
	preserve_old_lib /usr/$(get_libdir)/libdevhelp-1.so.1
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_need_rebuild
	python_mod_optimize /usr/$(get_libdir)/gedit-2/plugins/devhelp
	preserve_old_lib_notify /usr/$(get_libdir)/libdevhelp-1.so.1
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/gedit-2/plugins/devhelp
}
