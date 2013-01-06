# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-5.56.ebuild,v 1.8 2011/07/30 10:26:09 tove Exp $

EAPI=2

MY_PN=Date-Manip
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=SBECK
inherit perl-module

DESCRIPTION="Perl date manipulation routines"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod )"
#		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
mydoc="HISTORY"
