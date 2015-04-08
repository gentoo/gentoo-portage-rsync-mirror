# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dbus-c++/dbus-c++-0.9.0-r1.ebuild,v 1.3 2015/03/22 21:36:55 tetromino Exp $

EAPI="4"

inherit eutils

DESCRIPTION="Provides a C++ API for D-BUS"
HOMEPAGE="http://sourceforge.net/projects/dbus-cplusplus/ http://sourceforge.net/apps/mediawiki/dbus-cplusplus/index.php?title=Main_Page"
SRC_URI="mirror://sourceforge/dbus-cplusplus/lib${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE="doc ecore glib static-libs test"

RDEPEND="sys-apps/dbus
	ecore? ( dev-libs/ecore )
	glib? ( dev-libs/glib:2 )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	dev-util/cppunit
	virtual/pkgconfig"

S=${WORKDIR}/lib${P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc-4.7.patch #424707
}

src_configure() {
	econf \
		--disable-examples \
		$(use_enable doc doxygen-docs) \
		$(use_enable ecore) \
		$(use_enable glib) \
		$(use_enable static-libs static) \
		$(use_enable test tests)
}

src_install() {
	default
	prune_libtool_files
}
