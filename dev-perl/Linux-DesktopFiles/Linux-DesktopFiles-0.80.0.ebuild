# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Linux-DesktopFiles/Linux-DesktopFiles-0.80.0.ebuild,v 1.1 2013/11/02 17:06:43 hasufell Exp $

EAPI=5

MODULE_AUTHOR="TRIZEN"
MODULE_VERSION=0.08
inherit perl-module

DESCRIPTION="Perl module to get and parse the Linux .desktop files"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.14.0[gdbm]"
DEPEND="virtual/perl-Module-Build"

SRC_TEST="do"
