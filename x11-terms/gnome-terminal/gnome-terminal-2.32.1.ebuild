# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-2.32.1.ebuild,v 1.11 2012/10/20 04:48:30 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="The Gnome Terminal"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"
IUSE=""

# libgnome needed for some monospace font schema, bug #274638
RDEPEND=">=dev-libs/glib-2.25.12:2
	>=x11-libs/gtk+-2.18:2
	>=gnome-base/gconf-2.31.3
	>=x11-libs/vte-0.26.0:0
	x11-libs/libSM
	gnome-base/libgnome"
DEPEND="${RDEPEND}
	|| ( dev-util/gtk-builder-convert <=x11-libs/gtk+-2.24.10:2 )
	sys-devel/gettext
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	>=app-text/gnome-doc-utils-0.3.2
	>=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

src_prepare() {
	gnome2_src_prepare

	# Use login shell by default (#12900)
	epatch "${FILESDIR}"/${PN}-2.22.0-default_shell.patch
}
