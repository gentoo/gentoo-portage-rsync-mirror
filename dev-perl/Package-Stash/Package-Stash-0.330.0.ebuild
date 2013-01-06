# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Package-Stash/Package-Stash-0.330.0.ebuild,v 1.16 2012/12/31 16:55:24 ago Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.33
inherit perl-module

DESCRIPTION="Routines for manipulating stashes"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/Dist-CheckConflicts-0.20.0
	dev-perl/Package-DeprecationManager
	>=dev-perl/Package-Stash-XS-0.240.0"
# conflicts:
#	!<=dev-perl/Class-MOP-1.08
#	!<=dev-perl/namespace-clean-0.18
#	!<=dev-perl/MooseX-Role-WithOverloading-0.80
#	!<=dev-perl/MooseX-Method-Signatures-0.360.0

DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		dev-perl/Test-Fatal
		dev-perl/Test-Requires
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
