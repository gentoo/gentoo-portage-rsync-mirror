# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Output/Test-Output-1.30.0.ebuild,v 1.1 2014/12/09 21:14:17 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="Utilities to test STDOUT and STDERR messages"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="
	>=dev-perl/Capture-Tiny-0.170.0
	>=virtual/perl-File-Temp-0.170.0
	dev-perl/Sub-Exporter
	virtual/perl-Test-Simple
"
DEPEND="${RDEPEND}
	test? (
		virtual/perl-Test-Simple
		>=dev-perl/Test-Tester-0.107
	)
"

SRC_TEST=do
