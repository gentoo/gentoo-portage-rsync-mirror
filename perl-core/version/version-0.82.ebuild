# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/version/version-0.82.ebuild,v 1.9 2011/07/30 12:30:03 tove Exp $

EAPI=2

#inherit versionator
#MY_P=${PN}-$(delete_version_separator 2 )
#S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=JPEACOCK
inherit perl-module

DESCRIPTION="Perl extension for Version Objects"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.33.05"

SRC_TEST="do"
