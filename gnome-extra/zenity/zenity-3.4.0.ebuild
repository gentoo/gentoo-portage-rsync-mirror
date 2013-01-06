# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zenity/zenity-3.4.0.ebuild,v 1.1 2012/05/20 01:10:07 tetromino Exp $

EAPI="4"
GCONF_DEBUG="yes"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="Tool to display dialogs from the commandline and shell scripts"
HOMEPAGE="http://live.gnome.org/Zenity"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="libnotify +webkit"

RDEPEND=">=dev-libs/glib-2.8:2
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.0.0:3
	x11-libs/libX11
	x11-libs/pango
	libnotify? ( >=x11-libs/libnotify-0.6.1 )
	webkit? ( >=net-libs/webkit-gtk-1.4.0:3 )"

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
		$(use_enable libnotify)
		$(use_enable webkit webkitgtk)
		PERL=$(type -P false)"
	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
}

src_prepare() {
	# Fix crash with --forms --list, in next release
	epatch "${FILESDIR}/${P}-list-segfault.patch"
	epatch "${FILESDIR}/${P}-list-check.patch"
	# https://bugzilla.gnome.org/show_bug.cgi?id=676406
	epatch "${FILESDIR}/${PN}-3.4.0-list-default-column.patch"
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	rm "${ED}/usr/bin/gdialog" || die "rm gdialog failed!"
}
