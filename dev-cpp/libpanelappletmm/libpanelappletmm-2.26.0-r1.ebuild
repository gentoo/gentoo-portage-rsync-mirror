# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libpanelappletmm/libpanelappletmm-2.26.0-r1.ebuild,v 1.4 2012/05/04 03:44:57 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2 eutils

DESCRIPTION="C++ interface for gnome panel"
HOMEPAGE="http://www.gtkmm.org/"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=">=dev-cpp/gconfmm-2.4
	>=dev-cpp/glibmm-2.4:2
	>=dev-cpp/gtkmm-2.4:2.4
	|| ( gnome-base/gnome-panel[bonobo] <gnome-base/gnome-panel-2.32 )
	<gnome-base/gnome-panel-2.91.6"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	virtual/pkgconfig"

src_prepare() {
	gnome2_src_prepare

	# Following the change in gnome-panel, drop in-process support for bonobo applets here too, upstream bug #642637
	epatch "${FILESDIR}/${P}-no-shlib.patch"
}
