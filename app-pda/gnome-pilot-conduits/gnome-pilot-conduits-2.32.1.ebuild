# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot-conduits/gnome-pilot-conduits-2.32.1.ebuild,v 1.6 2012/05/03 20:20:59 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Gnome Pilot Conduits"
HOMEPAGE="http://live.gnome.org/GnomePilot"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-2.13:2
	>=app-pda/gnome-pilot-2.32
	>=dev-libs/libxml2-2.5"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF} --disable-static"
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete || die
}
