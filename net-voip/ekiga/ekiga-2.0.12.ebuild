# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/ekiga/ekiga-2.0.12.ebuild,v 1.6 2012/05/03 07:27:47 jdhore Exp $

EAPI="2"
inherit gnome2 eutils flag-o-matic

DESCRIPTION="H.323 and SIP VoIP softphone"
HOMEPAGE="http://www.ekiga.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="avahi dbus doc gnome sdl"

RDEPEND="~dev-libs/pwlib-1.10.$[${PV##*.}-2][ldap]
	~net-libs/opal-2.2.$[${PV##*.}-1]
	>=x11-libs/gtk+-2.4.0:2
	>=dev-libs/glib-2.0.0:2
	sdl? ( >=media-libs/libsdl-1.2.4 )
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	avahi? ( net-dns/avahi[dbus] )
	gnome? (
		>=gnome-base/libbonobo-2.2.0
		>=gnome-base/libgnomeui-2.2.0
		>=gnome-base/libgnome-2.2.0
		>=gnome-base/gconf-2.2.0
		>=gnome-base/orbit-2.5.0
		gnome-extra/evolution-data-server
		media-sound/pulseaudio )"

DEPEND="${RDEPEND}
	dev-lang/perl
	virtual/pkgconfig
	>=dev-util/intltool-0.20
	gnome? ( app-text/scrollkeeper
		doc? ( app-text/gnome-doc-utils ) )"

DOCS="AUTHORS ChangeLog NEWS"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable dbus)
		$(use_enable sdl)
		$(use_enable avahi)
		$(use_enable doc)
		$(use_enable gnome)
		--disable-scrollkeeper
		--disable-schemas-install"
}

src_unpack() {
	gnome2_src_unpack

	# Fix configure to install schemafile into the proper directory
	epatch "${FILESDIR}"/${PN}-1.99.0-configure.patch

	# Fix gnome-doc-utils detection
	epatch "${FILESDIR}"/${P}-gdu.patch

	# Use installed inittools, see bug #234851
	sed -i -e 's#$(top_builddir)/intltool-#intltool-#' configure \
		|| die "patching configure failed"
}

src_test() {
	# xml files don't follow dtd, see bug #235849
	# prevent tests to fail
	if use gnome; then
		sed -i -e "/,check-doc/d" help/Makefile \
			|| die "patching help/Makefile for tests failed"
		sed -i -e "/^check:/d" help/Makefile \
			|| die "patching help/Makefile for tests failed"
	fi

	emake -j1 check || die "emake check failed"
}

src_install() {
	if use gnome; then
		gnome2_src_install
	else
		emake DESTDIR="${D}" install || die "make install failed"

		dodoc ${DOCS}
	fi
}

pkg_postinst() {
	if use gnome; then
		gnome2_pkg_postinst

		# we need to fix the GConf permissions, see bug #59764
		einfo "Fixing GConf permissions for ekiga"
		ekiga-config-tool --fix-permissions
	fi
}
