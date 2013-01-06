# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-HiRes/Time-HiRes-1.97.19.ebuild,v 1.10 2010/01/05 19:25:22 nixnut Exp $

inherit versionator
MODULE_AUTHOR=JHI
MY_P="${PN}-$(delete_version_separator 2)"
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Perl Time::HiRes. High resolution alarm, sleep, gettimeofday, interval timers"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

mydoc="TODO"

SRC_TEST="do"
