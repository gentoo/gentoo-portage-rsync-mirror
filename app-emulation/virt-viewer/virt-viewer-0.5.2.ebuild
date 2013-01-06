# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-viewer/virt-viewer-0.5.2.ebuild,v 1.3 2012/05/03 18:49:07 jdhore Exp $

EAPI=4
inherit eutils gnome2 toolchain-funcs

DESCRIPTION="Graphical console client for connecting to virtual machines"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk3 nsplugin sasl +spice +vnc"

RDEPEND=">=app-emulation/libvirt-0.9.7
	>=dev-libs/libxml2-2.6
	gtk3? ( x11-libs/gtk+:3 )
	!gtk3? (
		>=x11-libs/gtk+-2.18:2
		>=gnome-base/libglade-2.6
		)
	nsplugin? (
		>=dev-libs/nspr-4
		>=x11-libs/gtk+-2.18:2
		>=gnome-base/libglade-2.6
		)
	spice? ( >=net-misc/spice-gtk-0.11[sasl?,gtk3?] )
	vnc? ( >=net-libs/gtk-vnc-0.4.3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nsplugin? ( >=net-misc/npapi-sdk-0.27 )"

REQUIRED_USE="|| ( spice vnc )
	nsplugin? ( !gtk3 )
	gtk3? ( !nsplugin )"

pkg_setup() {
	G2CONF="$(use_enable nsplugin plugin) $(use_with spice spice-gtk)"
	G2CONF="${G2CONF} $(use_with vnc gtk-vnc)"
	use gtk3 && G2CONF="${G2CONF} --with-gtk=3.0"
	use gtk3 || G2CONF="${G2CONF} --with-gtk=2.0"
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.5.x-npapi-sdk.patch
}

src_configure() {
	if use nsplugin; then
		export MOZILLA_PLUGIN_CFLAGS="$($(tc-getPKG_CONFIG) --cflags npapi-sdk nspr)"
		export MOZILLA_PLUGIN_LIBS="$($(tc-getPKG_CONFIG) --libs npapi-sdk nspr)"
	fi

	gnome2_src_configure
}
