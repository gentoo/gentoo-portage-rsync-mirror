# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Error/Error-0.170.170.ebuild,v 1.2 2012/04/28 02:44:51 aballier Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=0.17017
inherit perl-module

DESCRIPTION="Error/exception handling in an OO-ish way"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		>=dev-perl/Test-Pod-1.14
		>=dev-perl/Test-Pod-Coverage-1.04
	)
"

SRC_TEST="do"
