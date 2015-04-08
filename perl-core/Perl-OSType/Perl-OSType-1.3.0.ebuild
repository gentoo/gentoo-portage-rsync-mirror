# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Perl-OSType/Perl-OSType-1.3.0.ebuild,v 1.2 2014/10/18 19:22:50 vapier Exp $

EAPI=5

MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=1.003
inherit perl-module

DESCRIPTION="Map Perl operating system names to generic types"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.88
	)"

SRC_TEST="do"
