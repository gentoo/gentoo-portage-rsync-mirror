# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Load-XS/Class-Load-XS-0.40.0.ebuild,v 1.5 2012/12/25 18:27:17 blueness Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="XS implementation of parts of Class::Load"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-Load-0.150.0

"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.360.100
	test? (
		>=virtual/perl-Test-Simple-0.880.0
		>=dev-perl/Module-Implementation-0.40.0
		dev-perl/Test-Fatal
	)
"

SRC_TEST=do
