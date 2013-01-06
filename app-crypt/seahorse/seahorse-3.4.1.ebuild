# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-3.4.1.ebuild,v 1.3 2012/12/16 19:16:05 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="A GNOME application for managing encryption keys"
HOMEPAGE="http://www.gnome.org/projects/seahorse/index.html"

LICENSE="GPL-2+ FDL-1.1+"
SLOT="0"
IUSE="avahi debug ldap"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

COMMON_DEPEND="
	>=app-crypt/gcr-3.3.4
	>=dev-libs/glib-2.10:2
	>=x11-libs/gtk+-2.90.0:3
	>=gnome-base/gnome-keyring-3.1.5
	net-libs/libsoup:2.4
	x11-misc/shared-mime-info

	net-misc/openssh
	>=app-crypt/gpgme-1
	|| (
		=app-crypt/gnupg-2.0*
		=app-crypt/gnupg-1.4* )

	avahi? ( >=net-dns/avahi-0.6 )
	ldap? ( net-nds/openldap )
"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.3
	>=dev-util/intltool-0.35
	virtual/pkgconfig
"
# Need seahorse-plugins git snapshot
RDEPEND="${COMMON_DEPEND}
	!<app-crypt/seahorse-plugins-2.91.0_pre20110114
"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-pgp
		--enable-ssh
		--enable-pkcs11
		--disable-static
		--disable-scrollkeeper
		--enable-hkp
		$(use_enable avahi sharing)
		$(use_enable debug)
		$(use_enable ldap)"
	DOCS="AUTHORS ChangeLog NEWS README TODO THANKS"
}

src_prepare() {
	# in next release
	epatch "${FILESDIR}/${P}-g_clear_object.patch"

	# FIXME: Do not mess with CFLAGS with USE="debug"
	sed -e '/CFLAGS="$CFLAGS -g/d' \
		-e '/CFLAGS="$CFLAGS -O0/d' \
		-i configure.ac configure || die "sed 1 failed"

	gnome2_src_prepare
}
