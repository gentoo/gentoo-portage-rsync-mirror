# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme-extras/gnome-icon-theme-extras-3.4.0.ebuild,v 1.4 2012/10/04 15:06:26 ago Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit autotools gnome2

DESCRIPTION="Extra GNOME icons for specific devices and file types"
HOMEPAGE="http://www.gnome.org/ http://git.gnome.org/browse/gnome-icon-theme-extras/"

LICENSE="CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-themes/hicolor-icon-theme-0.10"
DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	virtual/pkgconfig"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"
# FIXME: double check potential LINGUAS problem
DOCS="AUTHORS README NEWS"
G2CONF="${G2CONF} --enable-icon-mapping"

src_prepare() {
	# Always use pre-rendered icons
	sed -e 's/"x$allow_rendering" = "xyes"/"x$allow_rendering" = "xdonotwant"/' \
		-i configure.ac -i configure || die
	# Avoid maintainer-mode
	eautoreconf

	gnome2_src_prepare
}
