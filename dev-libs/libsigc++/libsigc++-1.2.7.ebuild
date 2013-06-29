# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.2.7.ebuild,v 1.10 2013/06/29 12:18:33 tomjbe Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit autotools gnome2 eutils

DESCRIPTION="Typesafe callback system for standard C++"
HOMEPAGE="http://libsigc.sourceforge.net/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1.2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86"
IUSE=""

DEPEND="sys-devel/m4"
RDEPEND=""

pkg_setup() {
	DOCS="AUTHORS ChangeLog FEATURES IDEAS README NEWS TODO"
	G2CONF="${G2CONF} --enable-maintainer-mode --enable-threads"
}

src_prepare() {
	gnome2_src_prepare

	# fixes bug #219041
	sed -e 's:ACLOCAL_AMFLAGS = -I $(srcdir)/scripts:ACLOCAL_AMFLAGS = -I scripts:' \
		-i Makefile.{in,am}

	# fixes bug #469698
	sed -e 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:g' -i configure.in || die

	# Fix duplicated file installation, bug #346949
	epatch "${FILESDIR}/${P}-fix-install.patch"

	eautoreconf
}
