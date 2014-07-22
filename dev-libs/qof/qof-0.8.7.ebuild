# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qof/qof-0.8.7.ebuild,v 1.2 2014/07/22 10:43:29 ago Exp $

EAPI=5
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools gnome2

DESCRIPTION="A Query Object Framework"
HOMEPAGE="https://alioth.debian.org/projects/qof/"
SRC_URI="mirror://debian//pool/main/q/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="GPL-2"

SLOT="2"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc nls sqlite"

RDEPEND="
	dev-libs/libxml2
	dev-libs/glib:2
	sqlite? ( >=dev-db/sqlite-2.8.0:0 )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	!dev-libs/qof:0
	doc? (
		app-doc/doxygen
		dev-texlive/texlive-latex )
"

src_prepare() {
	sed -i -e 's/-g2 //' configure.ac || die
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

src_compile() {
	# upstream bug ????
	MAKEOPTS="${MAKEOPTS} -j1" gnome2_src_compile
}
