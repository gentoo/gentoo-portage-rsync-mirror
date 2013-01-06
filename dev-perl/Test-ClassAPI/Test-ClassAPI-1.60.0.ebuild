# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-ClassAPI/Test-ClassAPI-1.60.0.ebuild,v 1.2 2011/09/03 21:04:48 tove Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.06
inherit perl-module

DESCRIPTION="Provides basic first-pass API testing for large class trees"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-File-Spec-0.83
	virtual/perl-Test-Simple
	>=dev-perl/Class-Inspector-1.12
	dev-perl/Config-Tiny
	>=dev-perl/Params-Util-1.00"
DEPEND="${RDEPEND}"

SRC_TEST=do
