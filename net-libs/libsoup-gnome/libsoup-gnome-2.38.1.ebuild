# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libsoup-gnome/libsoup-gnome-2.38.1.ebuild,v 1.12 2012/10/28 16:28:49 armin76 Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

MY_PN=${PN/-gnome}
MY_P=${MY_PN}-${PV}

inherit autotools eutils gnome2

DESCRIPTION="GNOME plugin for libsoup"
HOMEPAGE="http://live.gnome.org/LibSoup"
SRC_URI="${SRC_URI//-gnome}"

LICENSE="LGPL-2+"
SLOT="2.4"
KEYWORDS="alpha amd64 arm ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-solaris"
IUSE="debug +introspection"

RDEPEND="~net-libs/libsoup-${PV}[introspection?]
	|| ( gnome-base/libgnome-keyring <gnome-base/gnome-keyring-2.29.4 )
	dev-db/sqlite:3
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=dev-util/gtk-doc-am-1.10"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	# Disable apache tests until they are usable on Gentoo, bug #326957
	G2CONF="${G2CONF}
		--disable-static
		--disable-tls-check
		$(use_enable introspection)
		--with-libsoup-system
		--with-gnome
		--without-apache-httpd"
	DOCS="AUTHORS NEWS README"
}

src_prepare() {
	# Use lib present on the system
	epatch "${FILESDIR}"/${PN}-2.38.0-system-lib.patch
	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	# FIXME: we need addpredict to workaround bug #324779 until
	# root cause (bug #249496) is solved
	addpredict /usr/share/snmp/mibs/.index
	gnome2_src_configure
}
