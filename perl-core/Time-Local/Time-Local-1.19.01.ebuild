# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Time-Local/Time-Local-1.19.01.ebuild,v 1.10 2010/11/25 21:12:13 grobian Exp $

inherit versionator
MODULE_AUTHOR=DROLSKY
MY_P=${PN}-$(delete_version_separator 2 )
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Implements timelocal() and timegm()"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
