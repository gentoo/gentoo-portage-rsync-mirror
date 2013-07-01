# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnome-online-accounts/gnome-online-accounts-3.8.2.ebuild,v 1.4 2013/07/01 21:06:31 eva Exp $

EAPI="5"
inherit gnome2

DESCRIPTION="GNOME framework for accessing online accounts"
HOMEPAGE="https://live.gnome.org/GnomeOnlineAccounts"

LICENSE="LGPL-2+"
SLOT="0"
IUSE="gnome +introspection kerberos"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# pango used in goaeditablelabel
# libsoup used in goaoauthprovider
# goa kerberos provider is incompatible with app-crypt/heimdal, see
# https://bugzilla.gnome.org/show_bug.cgi?id=692250
RDEPEND="
	>=dev-libs/glib-2.35:2
	app-crypt/libsecret
	dev-libs/json-glib
	dev-libs/libxml2:2
	>=net-libs/libsoup-2.42:2.4
	net-libs/rest:0.7
	net-libs/webkit-gtk:3
	>=x11-libs/gtk+-3.5.1:3
	x11-libs/pango

	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )
	kerberos? (
		app-crypt/gcr:0=
		app-crypt/mit-krb5 )
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
	gnome2_src_configure \
		--disable-static \
		--enable-documentation \
		--enable-exchange \
		--enable-facebook \
		--enable-flickr \
		--enable-imap-smtp \
		--enable-owncloud \
		$(use_enable kerberos)
}
