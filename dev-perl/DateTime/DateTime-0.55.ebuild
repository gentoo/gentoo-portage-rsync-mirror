# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime/DateTime-0.55.ebuild,v 1.8 2011/01/08 18:54:10 jer Exp $

EAPI=2

#inherit versionator
#MY_P=${PN}-$(delete_version_separator 2)
#S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="A date and time object"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Params-Validate-0.76
	>=virtual/perl-Time-Local-1.04
	>=dev-perl/DateTime-TimeZone-1.09
	>=dev-perl/DateTime-Locale-0.44"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Exception )"

SRC_TEST="do"
