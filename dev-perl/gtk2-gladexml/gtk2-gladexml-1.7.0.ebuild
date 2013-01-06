# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gtk2-gladexml/gtk2-gladexml-1.7.0.ebuild,v 1.6 2012/03/31 12:10:04 armin76 Exp $

EAPI=4

MY_PN=Gtk2-GladeXML
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.007
inherit perl-module

DESCRIPTION="Create user interfaces directly from Glade XML files."
HOMEPAGE="http://gtk2-perl.sf.net/ ${HOMEPAGE}"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	gnome-base/libglade:2.0
	>=dev-util/glade-2.0.0-r1
	>=dev-perl/glib-perl-1.020
	>=dev-perl/gtk2-perl-1.012"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.300
	dev-perl/extutils-pkgconfig"
