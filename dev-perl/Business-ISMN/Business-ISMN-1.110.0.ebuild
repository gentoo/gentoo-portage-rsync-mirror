# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-ISMN/Business-ISMN-1.110.0.ebuild,v 1.1 2012/09/11 03:21:08 tove Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.11
inherit perl-module

DESCRIPTION="International Standard Music Numbers"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Tie-Cycle
	virtual/perl-Scalar-List-Utils
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST=do

src_install() {
	perl-module_src_install
	rm -rf "${ED}"/usr/share/man || die
}
