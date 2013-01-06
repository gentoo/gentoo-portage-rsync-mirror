# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Most/Test-Most-0.310.0.ebuild,v 1.1 2012/09/07 09:08:57 tove Exp $

EAPI=4

MODULE_AUTHOR=OVID
MODULE_VERSION=0.31
inherit perl-module

DESCRIPTION="Most commonly needed test functions and features"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE=""

RDEPEND="
	>=dev-perl/Exception-Class-1.140.0
	>=dev-perl/Test-Warn-0.230.0
	>=dev-perl/Test-Deep-0.106
	>=dev-perl/Test-Differences-0.610.0
	>=dev-perl/Test-Exception-0.310.0
	>=virtual/perl-Test-Harness-3.210.0
	>=virtual/perl-Test-Simple-0.88
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.400.0
"

SRC_TEST=do
