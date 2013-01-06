# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/pan/pan-9999.ebuild,v 1.10 2012/11/04 09:17:06 tetromino Exp $

EAPI="4"

inherit autotools git-2

DESCRIPTION="A newsreader for GNOME"
HOMEPAGE="http://pan.rebelbase.com/"

EGIT_REPO_URI="git://git.gnome.org/${PN}2
	http://git.gnome.org/browse/${PN}2"
SRC_URI=

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus gnome-keyring libnotify spell ssl"

RDEPEND=">=dev-libs/glib-2.26:2
	>=x11-libs/gtk+-2.16:2
	dev-libs/gmime:2.6
	gnome-keyring? ( >=gnome-base/libgnome-keyring-3.2 )
	libnotify? ( >=x11-libs/libnotify-0.4.1 )
	spell? (
		>=app-text/enchant-1.6
		>=app-text/gtkspell-2.0.7:2 )
	ssl? ( >=net-libs/gnutls-3 )"

DEPEND="${RDEPEND}
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.35.5
	sys-devel/gettext
	virtual/pkgconfig"

# The normal version tree ebuild we are based on (for patching)
Pnorm="${PN}-0.139"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

src_prepare() {
	# bootstrap build system
	intltoolize --force --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf \
		--without-gtk3 \
		$(use_with dbus) \
		$(use_enable gnome-keyring gkr) \
		$(use_with spell gtkspell) \
		$(use_enable libnotify) \
		$(use_with ssl gnutls)
}
