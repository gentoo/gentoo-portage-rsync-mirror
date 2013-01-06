# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gtkglextmm/gtkglextmm-1.2.0-r1.ebuild,v 1.7 2012/05/04 03:44:58 jdhore Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="C++ bindings for gtkglext"
HOMEPAGE="http://projects.gnome.org/gtkglext/"
SRC_URI="mirror://sourceforge/gtkglext/${P}.tar.bz2"

KEYWORDS="amd64 ppc x86"
IUSE="doc"
SLOT="1.0"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=x11-libs/gtkglext-1
	>=dev-libs/libsigc++-2.0
	>=dev-cpp/glibmm-2.4:2
	>=dev-cpp/gtkmm-2.4:2.4
	virtual/opengl"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS ChangeLog* NEWS README TODO"

src_prepare() {
	gnome2_src_prepare

	# Remove docs from SUBDIRS so that docs are not installed, as
	# we handle it in src_install.
	sed -i -e 's|^\(SUBDIRS =.*\)docs\(.*\)|\1\2|' Makefile.in || \
		die "sed Makefile.in failed"

	# Remove -D.*DISABLE_DEPRECATED cflags, bug #342905
	find . -iname 'Makefile.am' -exec \
		sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' -i {} + || die "sed 1 failed"
	# Do Makefile.in after Makefile.am to avoid automake maintainer-mode
	find . -iname 'Makefile.in' -exec \
		sed -e '/-D[A-Z_]*DISABLE_DEPRECATED/d' -i {} + || die "sed 2 failed"
}

src_install() {
	gnome2_src_install
	if use doc; then
		dohtml -r docs/reference/html/* || die
	fi
}
