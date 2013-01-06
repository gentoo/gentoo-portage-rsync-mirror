# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/latexila/latexila-2.4.1.ebuild,v 1.3 2012/10/04 14:44:57 ago Exp $

EAPI="4"
CMAKE_MIN_VERSION="2.6.4"
CMAKE_IN_SOURCE_BUILD="yes" # for gnome2.eclass compat
GCONF_DEBUG="no"

inherit cmake-utils gnome2

DESCRIPTION="Integrated LaTeX environment for GNOME"
HOMEPAGE="http://projects.gnome.org/latexila/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnome +latexmk rubber vala"

COMMON_DEPEND="
	app-text/gtkspell:2
	>=dev-libs/glib-2.30:2
	dev-libs/libgee:0
	dev-libs/libunique:1
	>=x11-libs/gtk+-2.16:2
	>=x11-libs/gtksourceview-2.10:2.0
	x11-libs/gdk-pixbuf:2
	x11-libs/libX11
	x11-libs/pango
	gnome? ( gnome-base/gsettings-desktop-schemas )
	vala? ( >=dev-lang/vala-0.16.0:0.16 )
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

pkg_setup() {
	DOCS="AUTHORS HACKING NEWS README"
}

src_prepare() {
	if [[ -n ${LINGUAS+set} ]]; then
		# LINGUAS is set, let's try to respect it.
		pushd po > /dev/null
		local po_file
		for po_file in *.po; do
			has "${po_file%.po}" ${LINGUAS} || rm -v "${po_file}"
		done
		popd > /dev/null
	fi
}

src_configure() {
	local mycmakeargs="
		VALAC=$(type -p valac-0.16)
		$(cmake-utils_use_build vala VALA)
		$(cmake-utils_use_with gnome GNOME)
		-DCOMPILE_SCHEMA=OFF"
	cmake-utils_src_configure
}
