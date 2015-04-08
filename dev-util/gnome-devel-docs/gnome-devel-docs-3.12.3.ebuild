# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnome-devel-docs/gnome-devel-docs-3.12.3.ebuild,v 1.3 2014/12/19 13:36:30 pacho Exp $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Documentation for developing for the GNOME desktop environment"
HOMEPAGE="http://developer.gnome.org/"

# https://bugzilla.gnome.org/show_bug.cgi?id=735882
LICENSE="FDL-1.1+ CC-BY-SA-3.0 CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND=""
DEPEND="
	app-text/docbook-xml-dtd:4.1.2
	app-text/docbook-xml-dtd:4.2
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

src_configure() {
	gnome2_src_configure ITSTOOL=$(type -P true)
}
