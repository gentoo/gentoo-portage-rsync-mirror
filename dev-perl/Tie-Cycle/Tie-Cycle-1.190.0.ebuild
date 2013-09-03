# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tie-Cycle/Tie-Cycle-1.190.0.ebuild,v 1.1 2013/09/03 03:48:18 patrick Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.19
inherit perl-module

DESCRIPTION="Cycle through a list of values via a scalar"

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
	rm -rf "${ED}"/usr/share/man/
}
