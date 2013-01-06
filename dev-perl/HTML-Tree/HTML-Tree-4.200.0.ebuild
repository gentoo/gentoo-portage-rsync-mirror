# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Tree/HTML-Tree-4.200.0.ebuild,v 1.9 2012/03/08 15:09:49 ranger Exp $

EAPI=4

MODULE_AUTHOR=JFEARN
MODULE_VERSION=4.2
inherit perl-module

DESCRIPTION="A library to manage HTML-Tree in PERL"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-perl/HTML-Tagset-3.03
	>=dev-perl/HTML-Parser-3.46"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
