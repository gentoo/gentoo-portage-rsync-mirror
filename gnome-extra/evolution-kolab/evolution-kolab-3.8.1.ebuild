# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-kolab/evolution-kolab-3.8.1.ebuild,v 1.1 2013/04/17 17:51:10 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Evolution module for connecting to Kolab groupware servers"
HOMEPAGE="https://live.gnome.org/Evolution/Kolab"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="" # kerberos (does nothing useful for now)

RDEPEND="
	>=mail-client/evolution-${PV}:2.0
	=gnome-extra/evolution-data-server-${MY_MAJORV}*
	>=dev-db/sqlite-3.7:3
	>=dev-libs/glib-2.32:2
	>=dev-libs/libical-0.44
	dev-libs/libxml2
	dev-libs/nss
	>=gnome-base/gconf-2:2
	>=net-misc/curl-7.19[ssl]
	>=x11-libs/gtk+-3.2:3
"
DEPEND="${RDEPEND}
	dev-util/gperf
	>=dev-util/gtk-doc-am-1.14
	>=dev-util/intltool-0.35.5
	sys-devel/gettext
	virtual/pkgconfig
"

RESTRICT="test" # test suite is non-functional
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	# We do not want to install a "hello world" program.
	epatch "${FILESDIR}/${PN}-3.4.3-no-hello-world.patch"

	# Strip stupid cflags
	sed -e 's/\(ADD_CFLAGS=.*\) -pedantic/\1/' \
		-i configure.ac configure || die

	eautoreconf
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure --disable-static --without-krb5 # --with-krb5 does nothing useful
}

src_install() {
	gnome2_src_install
	rm -rv "${ED}usr/doc" || die "rm failed"
}
