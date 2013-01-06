# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Kismet/Net-Kismet-0.04.ebuild,v 1.12 2007/07/10 23:33:27 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Module for writing perl Kismet clients"
SRC_URI="http://www.kismetwireless.net/code/${P}.tar.gz"
HOMEPAGE="http://www.kismetwireless.net"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

src_compile() {

	perl-module_src_compile
	perl-module_src_test
}

DEPEND="dev-lang/perl"
