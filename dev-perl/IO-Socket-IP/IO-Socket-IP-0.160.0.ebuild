# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-IP/IO-Socket-IP-0.160.0.ebuild,v 1.3 2012/11/13 17:17:21 jer Exp $

EAPI=4

MODULE_AUTHOR=PEVANS
MODULE_VERSION=0.16
inherit perl-module

DESCRIPTION='A drop-in replacement for IO::Socket::INET supporting both IPv4 and IPv6'

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
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
