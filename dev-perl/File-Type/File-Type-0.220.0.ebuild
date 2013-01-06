# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Type/File-Type-0.220.0.ebuild,v 1.2 2011/09/03 21:05:03 tove Exp $

EAPI=4

MODULE_AUTHOR=PMISON
MODULE_VERSION=0.22
inherit perl-module

DESCRIPTION="Determine file type using magic"

SLOT="0"
KEYWORDS="amd64 hppa ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"

SRC_TEST="do"
