# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gtk2-WebKit/Gtk2-WebKit-0.90.0.ebuild,v 1.4 2012/07/29 17:45:09 armin76 Exp $

EAPI=4

MODULE_AUTHOR=FLORA
MODULE_VERSION=0.09
inherit perl-module

DESCRIPTION="Web content engine library for Gtk2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-perl/gtk2-perl
	net-libs/webkit-gtk:2"
DEPEND="${RDEPEND}
	dev-perl/glib-perl
	dev-perl/extutils-pkgconfig
	dev-perl/extutils-depends"

#SRC_TEST=do
