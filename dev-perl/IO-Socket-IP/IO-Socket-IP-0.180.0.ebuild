# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-IP/IO-Socket-IP-0.180.0.ebuild,v 1.2 2012/12/17 18:27:38 ago Exp $

EAPI=4

MODULE_AUTHOR=PEVANS
MODULE_VERSION=0.18
inherit perl-module

DESCRIPTION='A drop-in replacement for IO::Socket::INET supporting both IPv4 and IPv6'

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="
	>=virtual/perl-Socket-1.970.0
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
	)
"

SRC_TEST="do"

src_test() {
	rm t/21nonblocking-connect-internet.t || die
	perl-module_src_test
}
