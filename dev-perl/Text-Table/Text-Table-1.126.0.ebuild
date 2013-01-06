# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Table/Text-Table-1.126.0.ebuild,v 1.1 2012/09/24 18:19:11 tove Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=1.126
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
