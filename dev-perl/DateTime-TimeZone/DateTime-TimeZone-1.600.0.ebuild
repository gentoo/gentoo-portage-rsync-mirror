# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-TimeZone/DateTime-TimeZone-1.600.0.ebuild,v 1.12 2014/06/09 23:46:25 vapier Exp $

EAPI=5

MODULE_AUTHOR=DROLSKY
MODULE_VERSION=1.60
inherit perl-module

DESCRIPTION="Time zone object base class and factory"

SLOT="0"
KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	dev-perl/Class-Load
	>=dev-perl/Params-Validate-0.720.0
	>=dev-perl/Class-Singleton-1.30.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.310.0
	test? (
		>=virtual/perl-Test-Simple-0.920.0
	)
"

SRC_TEST="do"
