# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-user-docs/gnome-user-docs-2.32.0.ebuild,v 1.8 2012/05/05 06:25:23 jdhore Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="GNOME end user documentation"
HOMEPAGE="http://www.gnome.org/"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="test"

RDEPEND=""
DEPEND="app-text/scrollkeeper
	>=app-text/gnome-doc-utils-0.5.6
	virtual/pkgconfig
	test? (
		~app-text/docbook-xml-dtd-4.1.2
		~app-text/docbook-xml-dtd-4.3 )"

pkg_setup() {
	G2CONF="${G2CONF} --disable-scrollkeeper"
	DOCS="AUTHORS ChangeLog NEWS README"
}
