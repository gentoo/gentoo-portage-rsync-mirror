# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Alien-wxWidgets/Alien-wxWidgets-0.600.0.ebuild,v 1.1 2012/08/31 09:40:53 tove Exp $

EAPI=4

WX_GTK_VER="2.8"
MODULE_AUTHOR=MDOOTSON
MODULE_VERSION=0.60
inherit wxwidgets perl-module

DESCRIPTION="Building, finding and using wxWidgets binaries"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE="test"

RDEPEND="
	|| (
		x11-libs/wxGTK:2.9[X,tiff]
		>=x11-libs/wxGTK-2.8.11.0:2.8[X,tiff]
	)
	>=virtual/perl-Module-Pluggable-3.1-r1
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-CBuilder-0.24
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
