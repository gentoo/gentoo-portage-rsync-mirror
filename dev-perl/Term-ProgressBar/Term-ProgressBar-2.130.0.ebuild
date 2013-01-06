# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.130.0.ebuild,v 1.3 2012/12/11 18:08:33 ago Exp $

EAPI=4

MODULE_AUTHOR=SZABGAB
MODULE_VERSION=2.13
inherit perl-module

DESCRIPTION="Perl module for Term-ProgressBar"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
IUSE="test"

RDEPEND="
	dev-perl/Class-MethodMaker
	dev-perl/TermReadKey
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.310.0
		>=dev-perl/Capture-Tiny-0.130.0
	)
"

SRC_TEST="do"
