# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Linux-DesktopFiles/Linux-DesktopFiles-0.60.0.ebuild,v 1.3 2012/08/27 13:32:16 johu Exp $

EAPI=4

MODULE_AUTHOR="TRIZEN"
MODULE_VERSION=0.06
inherit perl-module

DESCRIPTION="Perl module to get and parse the Linux .desktop files"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-lang/perl[gdbm]"
DEPEND="virtual/perl-Module-Build"

SRC_TEST="do"
