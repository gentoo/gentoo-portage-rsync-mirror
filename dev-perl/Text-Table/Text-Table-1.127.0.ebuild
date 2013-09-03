# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Table/Text-Table-1.127.0.ebuild,v 1.1 2013/09/03 05:52:10 patrick Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=1.127
inherit perl-module

DESCRIPTION="Organize Data in Tables"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Text-Aligner-0.50.0"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.360.0
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"

src_install() {
	perl-module_src_install
	docinto examples
	docompress -x /usr/share/doc/${PF}/examples
	dodoc examples/Text-Table-UTF8-example.pl
}
