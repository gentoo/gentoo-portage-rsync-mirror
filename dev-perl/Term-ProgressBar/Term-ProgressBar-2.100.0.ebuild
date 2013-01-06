# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.100.0.ebuild,v 1.4 2012/02/02 19:47:17 ranger Exp $

EAPI=4

MODULE_AUTHOR=SZABGAB
MODULE_VERSION=2.10
inherit perl-module

DESCRIPTION="Perl module for Term-ProgressBar"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
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

src_test() {
	rm "${S}"/t/0-signature.t || die
	perl-module_src_test
}
