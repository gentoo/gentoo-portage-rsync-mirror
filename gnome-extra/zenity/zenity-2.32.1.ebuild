# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zenity/zenity-2.32.1.ebuild,v 1.9 2012/05/05 06:25:16 jdhore Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit eutils gnome2

DESCRIPTION="Tool to display dialogs from the commandline and shell scripts"
HOMEPAGE="http://live.gnome.org/Zenity"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="+compat libnotify"

RDEPEND=">=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.8:2
	compat? ( >=dev-lang/perl-5 )
	libnotify? ( >=x11-libs/libnotify-0.4.1 )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	app-text/docbook-xml-dtd:4.1.2
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.14
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.10.1"
# eautoreconf needs:
#	>=gnome-base/gnome-common-2.12

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--with-gtk=2.0
		$(use_enable libnotify)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	if ! use compat; then
		rm "${ED}/usr/bin/gdialog" || die "rm gdialog failed!"
	fi
}
