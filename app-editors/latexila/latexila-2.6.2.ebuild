# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/latexila/latexila-2.6.2.ebuild,v 1.3 2013/03/25 16:14:02 ago Exp $

EAPI="4"
GCONF_DEBUG="no"
VALA_MIN_API_VERSION="0.18"

inherit gnome2 vala

DESCRIPTION="Integrated LaTeX environment for GNOME"
HOMEPAGE="http://projects.gnome.org/latexila/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+latexmk rubber"

COMMON_DEPEND="
	app-text/enchant
	>=dev-libs/glib-2.32:2
	dev-libs/libgee:0
	gnome-base/gsettings-desktop-schemas
	>=x11-libs/gtk+-3.4.3:3
	>=x11-libs/gtksourceview-3.4.1:3.0
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

DOCS="AUTHORS HACKING NEWS README"
