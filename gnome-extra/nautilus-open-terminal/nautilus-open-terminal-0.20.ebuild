# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-open-terminal/nautilus-open-terminal-0.20.ebuild,v 1.4 2013/12/08 18:56:29 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Nautilus Plugin for Opening Terminals"
HOMEPAGE="http://manny.cluecoder.org/packages/nautilus-open-terminal/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-2.4:2
	>=dev-libs/glib-2.16:2
	>=gnome-base/nautilus-2.91.90
	>=gnome-base/gnome-desktop-2.91.90:3=
	gnome-base/gconf:2
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	# Be a bit more future proof, bug #260903
	sed "s/-Werror//" -i src/Makefile.am src/Makefile.in || die "sed failed"

	gnome2_src_prepare
}

src_configure() {
	DOCS="AUTHORS ChangeLog INSTALL NEWS README TODO"
	gnome2_src_configure --disable-static
}
