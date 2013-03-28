# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/zenity/zenity-3.8.0.ebuild,v 1.1 2013/03/28 17:33:23 pacho Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit gnome2

DESCRIPTION="Tool to display dialogs from the commandline and shell scripts"
HOMEPAGE="http://live.gnome.org/Zenity"

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="libnotify test +webkit"

RDEPEND=">=dev-libs/glib-2.8:2
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3:3
	x11-libs/libX11
	x11-libs/pango
	libnotify? ( >=x11-libs/libnotify-0.6.1:= )
	webkit? ( >=net-libs/webkit-gtk-1.4.0:3 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	>=sys-devel/gettext-0.14
	virtual/pkgconfig
	test? ( app-text/yelp-tools )"
# eautoreconf needs:
#	>=gnome-base/gnome-common-2.12

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README THANKS TODO"
	G2CONF="${G2CONF}
		$(use_enable libnotify)
		$(use_enable webkit webkitgtk)
		PERL=$(type -P false)
		ITSTOOL=$(type -P true)"

	gnome2_src_configure
}

src_install() {
	gnome2_src_install

	rm "${ED}/usr/bin/gdialog" || die "rm gdialog failed!"
}
