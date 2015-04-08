# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qof/qof-0.8.8.ebuild,v 1.4 2015/04/02 18:35:49 mr_bones_ Exp $

EAPI=5
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="A Query Object Framework"
HOMEPAGE="https://alioth.debian.org/projects/qof/"
SRC_URI="mirror://debian//pool/main/q/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE="doc nls sqlite"

RDEPEND="
	dev-libs/libxml2
	dev-libs/glib:2
	sqlite? ( >=dev-db/sqlite-2.8.0:0 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	virtual/yacc
	>=sys-devel/gettext-0.19.2
	!dev-libs/qof:0
	doc? (
		app-doc/doxygen
		dev-texlive/texlive-latex )
"

src_prepare() {
	# Remove some CFLAGS
	epatch "${FILESDIR}"/${PN}-0.8.8-cflags.patch

	# Delay build of unittests, bug #197999
	epatch "${FILESDIR}"/${PN}-0.8.8-unittest.patch

	# Fix use and build with yacc
	epatch "${FILESDIR}"/${PN}-0.8.8-unistd-define.patch
	epatch "${FILESDIR}"/${PN}-0.8.8-yacc-build.patch
	rm lib/libsql/{lexer.c,parser.c,parser.h} || die

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-error-on-warning \
		--disable-static \
		--disable-gdasql \
		--disable-gdabackend \
		$(use_enable nls) \
		$(use_enable sqlite) \
		$(use_enable doc doxygen) \
		$(use_enable doc latex-docs) \
		$(use_enable doc html-docs)
}
