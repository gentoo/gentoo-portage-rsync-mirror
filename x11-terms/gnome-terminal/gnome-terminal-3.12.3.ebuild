# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-3.12.3.ebuild,v 1.2 2014/07/22 10:54:30 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2 readme.gentoo

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="https://wiki.gnome.org/Apps/Terminal/"

LICENSE="GPL-3+"
SLOT="0"
IUSE="+gnome-shell +nautilus"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux"

# FIXME: automagic dependency on gtk+[X]
RDEPEND="
	>=dev-libs/glib-2.39.2:2
	>=x11-libs/gtk+-3.9.9:3[X]
	>=x11-libs/vte-0.36.3:2.90
	>=gnome-base/dconf-0.14
	>=gnome-base/gconf-2.31.3
	>=gnome-base/gsettings-desktop-schemas-0.1.0
	sys-apps/util-linux
	x11-libs/libSM
	x11-libs/libICE
	gnome-shell? ( gnome-base/gnome-shell )
	nautilus? ( >=gnome-base/nautilus-3 )
"
# gtk+:2 needed for gtk-builder-convert, bug 356239
DEPEND="${RDEPEND}
	app-text/yelp-tools
	dev-util/appdata-tools
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
	>=dev-util/intltool-0.50
	sys-devel/gettext
	virtual/pkgconfig
"

DOC_CONTENTS="To get previous working directory inherited in new opened
	tab you will need to add the following line to your ~/.bashrc:\n
	. /etc/profile.d/vte.sh"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-3.12.0-remove-set-title-feature-0.patch \
		"${FILESDIR}"/${PN}-3.12.0-remove-set-title-feature-1.patch \
		"${FILESDIR}"/${PN}-3.12.0-remove-set-title-feature-2.patch \
		"${FILESDIR}"/${PN}-3.12.0-remove-set-title-feature-3.patch \
		"${FILESDIR}"/${PN}-3.12.0-fallback-title-1.patch \
		"${FILESDIR}"/${PN}-3.12.0-fallback-title-2.patch

	gnome2_src_prepare
}
src_configure() {
	# FIXME: leave smclient configure unset until it accepts values from the
	# switch and not from GDK_TARGET, bug #363033
	gnome2_src_configure \
		--disable-static \
		--enable-migration \
		$(use_enable gnome-shell search-provider) \
		$(use_with nautilus nautilus-extension) \
		# Docs are broken in this release.
		#ITSTOOL=$(type -P true) \
		#XMLLINT=$(type -P true)
}

src_install() {
	DOCS="AUTHORS ChangeLog HACKING NEWS"
	gnome2_src_install
	readme.gentoo_create_doc
}

pkg_postinst() {
	gnome2_pkg_postinst
	readme.gentoo_print_elog
}
