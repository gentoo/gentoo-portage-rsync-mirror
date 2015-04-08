# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Alien-wxWidgets/Alien-wxWidgets-0.640.0-r1.ebuild,v 1.1 2014/08/25 02:20:49 axs Exp $

EAPI=5

WX_GTK_VER="2.8"
MODULE_AUTHOR=MDOOTSON
MODULE_VERSION=0.64
inherit wxwidgets perl-module

DESCRIPTION="Building, finding and using wxWidgets binaries"

SLOT="0"
KEYWORDS="amd64 ~ia64 x86"
IUSE="test"

RDEPEND="
	>=x11-libs/wxGTK-2.8.11.0:2.8[X,tiff]
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

src_configure() {
	myconf=( --wxWidgets-build=0 )
	perl-module_src_configure
}
