# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-6.320.0.ebuild,v 1.2 2012/07/25 05:07:22 ryao Exp $

EAPI=4

MY_PN=Date-Manip
MODULE_AUTHOR=SBECK
MODULE_VERSION=6.32
inherit perl-module

DESCRIPTION="Perl date manipulation routines"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="test"

RDEPEND="
	dev-perl/YAML-Syck
	virtual/perl-Storable
"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.380.0
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Inter
	)
"

SRC_TEST="do"

mydoc="HISTORY"
