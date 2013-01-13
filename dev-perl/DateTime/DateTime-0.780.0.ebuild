# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime/DateTime-0.780.0.ebuild,v 1.6 2013/01/13 17:48:57 maekke Exp $

EAPI=4

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=0.78
inherit perl-module

DESCRIPTION="A date and time object"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/Params-Validate-0.760.0
	>=dev-perl/DateTime-TimeZone-1.90.0
	>=dev-perl/DateTime-Locale-0.440.0
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Fatal
	)
"

SRC_TEST="do"
