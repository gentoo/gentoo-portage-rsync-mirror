# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/glib-networking/glib-networking-2.30.2.ebuild,v 1.12 2012/09/25 11:53:27 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2
# tests need virtualx

DESCRIPTION="Network-related giomodules for glib"
HOMEPAGE="http://git.gnome.org/browse/glib-networking/"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+gnome +libproxy +ssl" # test

RDEPEND=">=dev-libs/glib-2.29.16:2
	gnome? ( gnome-base/gsettings-desktop-schemas )
	libproxy? ( >=net-libs/libproxy-0.4.6-r3 )
	ssl? (
		app-misc/ca-certificates
		dev-libs/libgcrypt
		>=net-libs/gnutls-2.1.7 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	virtual/pkgconfig
	sys-devel/gettext"
#	test? ( sys-apps/dbus[X] )"
# eautoreconf needs >=sys-devel/autoconf-2.65:2.5

# FIXME: tls tests often fail, figure out why, bug #387799
# ERROR:tls.c:265:on_input_read_finish: assertion failed (error == NULL): Error performing TLS handshake: The request is invalid. (g-tls-error-quark, 1)
RESTRICT="test"

pkg_setup() {
	# AUTHORS, ChangeLog are empty
	DOCS="NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--with-ca-certificates="${EPREFIX}"/etc/ssl/certs/ca-certificates.crt
		$(use_with gnome gnome-proxy)
		$(use_with libproxy)
		$(use_with ssl gnutls)"
}

src_prepare() {
	gnome2_src_prepare

	# Drop DEPRECATED flags
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		proxy/libproxy/Makefile.am proxy/libproxy/Makefile.in \
		proxy/gnome/Makefile.am proxy/gnome/Makefile.in \
		tls/gnutls/Makefile.am tls/gnutls/Makefile.in || die
}

#src_test() {
	# global make check fails if gnome-proxy test is not built
#	use gnome || cd tls/tests
#	Xemake check
#}
