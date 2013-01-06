# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnome-devel-docs/gnome-devel-docs-2.32.0.ebuild,v 1.8 2012/12/17 11:31:40 tetromino Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Documentation for developing for the GNOME desktop environment"
HOMEPAGE="http://developer.gnome.org/"

LICENSE="FDL-1.1+"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/pkgconfig
	app-text/gnome-doc-utils
	~app-text/docbook-xml-dtd-4.2"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
	DOCS="AUTHORS ChangeLog NEWS README"
}
