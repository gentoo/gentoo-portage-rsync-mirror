# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-ews/evolution-ews-3.6.1.ebuild,v 1.2 2012/12/24 04:41:51 tetromino Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools db-use eutils flag-o-matic gnome2 versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Evolution module for connecting to Microsoft Exchange Web Services"
HOMEPAGE="http://www.gnome.org/projects/evolution/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="kerberos"

RDEPEND="
	dev-db/sqlite:3=
	dev-libs/libical:=
	>=mail-client/evolution-${PV}:2.0[kerberos?]
	>=gnome-extra/evolution-data-server-${PV}:=[kerberos?]
	=gnome-extra/evolution-data-server-${MY_MAJORV}*
	>=dev-libs/glib-2.28:2
	>=dev-libs/libxml2-2
	>=net-libs/libsoup-2.30:2.4
	>=x11-libs/gtk+-3:3
	kerberos? ( virtual/krb5:= )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.35.5
	virtual/pkgconfig
"

# Requires connection to an Exchange server
RESTRICT="test"

src_prepare() {
	# https://bugzilla.gnome.org/show_bug.cgi?id=690474
	epatch "${FILESDIR}/${PN}-3.6.1-libm.patch"
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	G2CONF="${G2CONF} $(use_with kerberos krb5)"
	gnome2_src_configure
}
