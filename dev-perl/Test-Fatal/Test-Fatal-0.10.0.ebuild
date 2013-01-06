# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Fatal/Test-Fatal-0.10.0.ebuild,v 1.10 2012/09/09 16:19:28 armin76 Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.010
inherit perl-module

DESCRIPTION="Incredibly simple helpers for testing code with exceptions"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Try-Tiny-0.70.0"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.30
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
