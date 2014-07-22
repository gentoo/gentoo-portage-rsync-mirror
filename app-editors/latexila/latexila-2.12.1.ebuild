# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/latexila/latexila-2.12.1.ebuild,v 1.2 2014/07/22 10:42:02 ago Exp $

EAPI="5"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.20"

inherit gnome2 vala

DESCRIPTION="Integrated LaTeX environment for GNOME"
HOMEPAGE="https://wiki.gnome.org/Apps/LaTeXila"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+latexmk rubber"

COMMON_DEPEND="
	app-text/enchant
	>=app-text/gtkspell-3.0.4:3
	>=dev-libs/glib-2.40:2
	dev-libs/libgee:0
	gnome-base/gsettings-desktop-schemas
	>=x11-libs/gtk+-3.6.0:3
	>=x11-libs/gtksourceview-3.10.0:3.0
	x11-libs/gdk-pixbuf:2
	x11-libs/libX11
	x11-libs/pango
	$(vala_depend)
"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	x11-themes/hicolor-icon-theme
	latexmk? ( dev-tex/latexmk )
	rubber? ( dev-tex/rubber )
"
DEPEND="${COMMON_DEPEND}
	dev-util/itstool
	virtual/pkgconfig
	sys-devel/gettext
"

src_prepare() {
	DOCS="AUTHORS HACKING NEWS README"
	gnome2_src_prepare
	vala_src_prepare
}
