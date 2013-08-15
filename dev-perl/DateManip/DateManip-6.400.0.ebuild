# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-6.400.0.ebuild,v 1.1 2013/08/15 06:07:47 patrick Exp $

EAPI=5

MY_PN=Date-Manip
MODULE_AUTHOR=SBECK
MODULE_VERSION=6.40
inherit perl-module

DESCRIPTION="Perl date manipulation routines"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="test"

RDEPEND="
	virtual/perl-Storable
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.390.0
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Inter
	)
"

SRC_TEST="do"

mydoc="HISTORY"
