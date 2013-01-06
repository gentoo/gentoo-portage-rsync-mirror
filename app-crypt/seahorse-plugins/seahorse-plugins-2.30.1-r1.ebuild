# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse-plugins/seahorse-plugins-2.30.1-r1.ebuild,v 1.9 2012/05/03 18:16:37 jdhore Exp $

EAPI="2"

inherit eutils gnome2

DESCRIPTION="A GNOME application for managing encryption keys"
HOMEPAGE="http://www.gnome.org/projects/seahorse/index.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE="applet debug gedit libnotify nautilus test"

RDEPEND="
	>=gnome-base/gconf-2.0
	>=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.16
	>=dev-libs/dbus-glib-0.72
	>=app-crypt/gpgme-1.0.0
	>=app-crypt/seahorse-2.25
	>=gnome-base/gnome-keyring-2.25

	|| (
		=app-crypt/gnupg-1.4*
		=app-crypt/gnupg-2.0* )

	nautilus? ( >=gnome-base/nautilus-2.12 )
	gedit? ( >=app-editors/gedit-2.16 )
	applet? ( >=gnome-base/gnome-panel-2.10 )
	libnotify? ( >=x11-libs/libnotify-0.3.2 )"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.3
	virtual/pkgconfig
	>=dev-util/intltool-0.35"

pkg_setup() {
	G2CONF="${G2CONF}
		--enable-agent
		--disable-update-mime-database
		--disable-static
		--disable-epiphany
		$(use_enable applet)
		$(use_enable debug)
		$(use_enable gedit)
		$(use_enable libnotify)
		$(use_enable nautilus)
		$(use_enable test tests)"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch

	# Use gpgme_engine_check_version() before gpgm_new() due current gpgme, bug #281729
	epatch "${FILESDIR}"/${PN}-2.28.1-gpgme_check_version.patch

	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	find "${D}" -name "*.la" -delete || die "remove of la files failed"

	exeinto /etc/X11/xinit/xinitrc.d/
	doexe "${FILESDIR}/70-seahorse-agent" || die "doexe failed"
}
