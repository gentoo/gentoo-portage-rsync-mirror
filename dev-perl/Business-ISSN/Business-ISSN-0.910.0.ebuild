# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Business-ISSN/Business-ISSN-0.910.0.ebuild,v 1.1 2012/09/11 03:31:54 tove Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=0.91
inherit perl-module

DESCRIPTION="Object and functions to work with International Standard Serial Numbers"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
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
