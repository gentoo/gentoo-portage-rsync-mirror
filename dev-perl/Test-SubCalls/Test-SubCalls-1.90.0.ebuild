# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SubCalls/Test-SubCalls-1.90.0.ebuild,v 1.3 2012/03/28 17:33:00 armin76 Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=1.09
inherit perl-module

DESCRIPTION="Track the number of times subs are called"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND=">=dev-perl/Hook-LexWrap-0.20
	virtual/perl-File-Spec"
RDEPEND="${DEPEND}"

SRC_TEST="do"
