# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gdome2/gdome2-0.8.1-r4.ebuild,v 1.10 2013/04/10 08:52:45 pinkbyte Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 toolchain-funcs

DESCRIPTION="The DOM C library for the GNOME project"
HOMEPAGE="http://gdome2.cs.unibo.it/"
SRC_URI="http://gdome2.cs.unibo.it/tarball/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RESTRICT="test"

RDEPEND=">=dev-libs/glib-2.2.0
	>=dev-libs/libxml2-2.4.26"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	G2CONF="${G2CONF} --disable-static"
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README*"
}

src_prepare() {
	# Fix broken GLIB_CONFIG in configure.in, see #114542
	epatch "${FILESDIR}/${P}-gdome2-config.patch"

	# make docs honor DESTDIR
	epatch "${FILESDIR}/${P}-docs-destdir.patch"

	# Fix build with libxml2-2.9.0 - bug 448236
	epatch "${FILESDIR}/${P}-libxml2.patch"

	# prevent gtk-fixxref from running (will cause sandbox violation)
	sed -i -e 's:gtkdoc-fixxref:#gtkdoc-fixxref:' gtk-doc/Makefile* || die

	# respect AR, bug #459844
	tc-export AR

	eautoconf

	gnome2_src_prepare
}
