# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ZMQ-LibZMQ2/ZMQ-LibZMQ2-1.30.0.ebuild,v 1.4 2012/12/17 18:27:57 ago Exp $

EAPI=4

MODULE_AUTHOR=DMAKI
MODULE_VERSION=1.03
inherit perl-module

DESCRIPTION="A libzmq 2.x wrapper for Perl"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="test"

RDEPEND="
	net-libs/zeromq
	>=dev-perl/ZMQ-Constants-1.0.0
	>=virtual/perl-XSLoader-0.20.0
"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.360.0
	virtual/pkgconfig
	test? (
		dev-perl/Test-Requires
		dev-perl/Test-Fatal
		>=dev-perl/Test-TCP-1.80.0
		>=virtual/perl-Test-Simple-0.980.0
	)
"

SRC_TEST=do
