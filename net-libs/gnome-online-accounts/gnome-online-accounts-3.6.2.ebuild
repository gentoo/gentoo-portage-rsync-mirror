# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnome-online-accounts/gnome-online-accounts-3.6.2.ebuild,v 1.4 2013/01/06 09:59:24 ago Exp $

EAPI="5"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GNOME framework for accessing online accounts"
HOMEPAGE="https://live.gnome.org/GnomeOnlineAccounts"

LICENSE="LGPL-2"
SLOT="0"
IUSE="gnome +introspection kerberos"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# pango used in goaeditablelabel
# libsoup used in goaoauthprovider
RDEPEND="
	>=dev-libs/glib-2.32:2
	app-crypt/libsecret
	dev-libs/json-glib
	dev-libs/libxml2:2
	net-libs/libsoup:2.4
	>=net-libs/libsoup-gnome-2.38:2.4
	net-libs/rest:0.7
	net-libs/webkit-gtk:3
	>=x11-libs/gtk+-3.5.1:3
	>=x11-libs/libnotify-0.7:=
	x11-libs/pango

	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )
	kerberos? (
		app-crypt/gcr
		virtual/krb5 )
"
# goa-daemon can launch gnome-control-center
PDEPEND="gnome? ( >=gnome-base/gnome-control-center-3.2[gnome-online-accounts(+)] )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-util/gtk-doc-am-1.3
	>=dev-util/gdbus-codegen-2.30.0
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	# TODO: Give users a way to set the G/Y!/FB/Twitter/Windows Live secrets
	G2CONF="${G2CONF}
		--disable-static
		--enable-documentation
		--enable-exchange
		--enable-facebook
		--enable-windows-live
		$(use_enable kerberos)"
	gnome2_src_configure
}
