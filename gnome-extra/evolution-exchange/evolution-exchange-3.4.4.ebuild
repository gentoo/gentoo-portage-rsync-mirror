# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/evolution-exchange/evolution-exchange-3.4.4.ebuild,v 1.2 2012/12/24 04:47:56 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit gnome2 versionator

MY_MAJORV=$(get_version_component_range 1-2)

DESCRIPTION="Evolution module for connecting to Microsoft Exchange"
HOMEPAGE="http://projects.gnome.org/evolution/"
LICENSE="GPL-2"

SLOT="2.0"
IUSE="debug doc static"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=mail-client/evolution-${PV}:2.0
	>=gnome-extra/evolution-data-server-${PV}[ldap,kerberos]
	=gnome-extra/evolution-data-server-${MY_MAJORV}*
	>=dev-libs/glib-2.28:2
	>=x11-libs/gtk+-3.0:3
	>=gnome-base/gconf-2:2
	>=dev-libs/libical-0.43
	dev-libs/libxml2:2
	net-libs/libsoup:2.4
	>=net-nds/openldap-2.1.30-r2
	virtual/krb5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--with-krb5=${EPREFIX}/usr
		--with-openldap
		--disable-static
		$(use_enable debug e2k-debug)
		$(use_with static static-ldap)"
	DOCS="AUTHORS ChangeLog NEWS README"
}
