# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-gconf/gnome2-gconf-1.44.0.ebuild,v 1.2 2012/05/04 04:10:57 jdhore Exp $

EAPI=4

MY_PN=Gnome2-GConf
MODULE_AUTHOR=TSCH
MODULE_VERSION=1.044
inherit perl-module

DESCRIPTION="Perl wrappers for the GConf configuration engine."

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="gnome-base/gconf:2
	>=dev-perl/glib-perl-1.120
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-pkgconfig-1.03
	>=dev-perl/extutils-depends-0.202
	virtual/pkgconfig"
SRC_TEST=do
