# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openconnect/networkmanager-openconnect-0.9.8.4-r1.ebuild,v 1.1 2014/03/12 04:40:46 tetromino Exp $

EAPI="5"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"

inherit eutils gnome.org gnome2-utils user

DESCRIPTION="NetworkManager OpenConnect plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="
	>=net-misc/networkmanager-0.9.8:=
	>=dev-libs/dbus-glib-0.74
	dev-libs/libxml2:2
	gnome-base/libgnome-keyring
	>=net-misc/openconnect-3.02:=
	gtk? (
		>=x11-libs/gtk+-2.91.4:3
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	virtual/pkgconfig
"

src_prepare() {
	# fix build failure with >=openconnect-5.99; in next release
	epatch "${FILESDIR}/${P}-auth-dialog-"{formchoice,newgroup,ignore}.patch
	gnome2_disable_deprecation_warning
	default
}

src_configure() {
	econf \
		--disable-more-warnings \
		--disable-static \
		--with-gtkver=3 \
		$(use_with gtk gnome) \
		$(use_with gtk authdlg)
}

src_install() {
	default
	prune_libtool_files --modules
}

pkg_postinst() {
	enewgroup nm-openconnect
	enewuser nm-openconnect -1 -1 -1 nm-openconnect
}
