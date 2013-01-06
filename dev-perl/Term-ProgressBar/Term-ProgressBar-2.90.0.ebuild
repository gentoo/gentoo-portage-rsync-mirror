# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.90.0.ebuild,v 1.2 2011/09/03 21:04:52 tove Exp $

EAPI=4

MODULE_AUTHOR=FLUFFY
MODULE_VERSION=2.09
inherit perl-module

DESCRIPTION="Perl module for Term-ProgressBar"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE=""

RDEPEND="dev-perl/Class-MethodMaker
	dev-perl/TermReadKey"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.28"

SRC_TEST="do"

src_test() {
	rm "${S}"/t/0-signature.t || die
	perl-module_src_test
}
