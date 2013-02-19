# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-5.30.0.ebuild,v 1.3 2013/02/19 02:36:00 zmedico Exp $

EAPI=4

MODULE_AUTHOR=CJM
MODULE_VERSION=5.03
inherit perl-module

DESCRIPTION="A library to manage HTML-Tree in PERL"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND="
	>=dev-perl/HTML-Tagset-3.03
	>=dev-perl/HTML-Parser-3.46
"
#	dev-perl/HTML-Format
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Fatal
	)
"

SRC_TEST="do"
