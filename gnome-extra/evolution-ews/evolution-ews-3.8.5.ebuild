# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-ews/evolution-ews-3.8.5.ebuild,v 1.1 2013/08/25 22:16:13 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

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
	>=dev-libs/glib-2.32:2
	>=dev-libs/libxml2-2
	>=net-libs/libsoup-2.38.1:2.4
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

src_configure() {
	# We don't have libmspack, needing internal lzx
	gnome2_src_configure \
		--with-internal-lzx \
		$(use_with kerberos krb5)
}
