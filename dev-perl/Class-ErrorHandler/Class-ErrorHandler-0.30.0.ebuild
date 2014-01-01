# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-ErrorHandler/Class-ErrorHandler-0.30.0.ebuild,v 1.2 2014/01/01 16:03:04 jer Exp $

EAPI=5

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Automated accessor generation"

SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="virtual/perl-Module-Build"

SRC_TEST="do"
PREFER_BUILDPL="no"
