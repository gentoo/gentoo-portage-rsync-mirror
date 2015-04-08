# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/2ping/2ping-2.1.1.ebuild,v 1.3 2014/07/21 19:05:53 dilfridge Exp $

EAPI="5"

inherit perl-module

DESCRIPTION="A bi-directional ping utility"
HOMEPAGE="http://www.finnie.org/software/2ping/"
SRC_URI="http://www.finnie.org/software/2ping/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crc ipv6 md5 sha server"

# The 2ping script itself checks if these optional deps are available.
DEPEND="
	>=dev-lang/perl-5.6.0:=
	virtual/perl-Getopt-Long
	virtual/perl-Pod-Parser
	virtual/perl-IO
	virtual/perl-Time-HiRes
	ipv6? ( dev-perl/IO-Socket-INET6 )
	md5? ( virtual/perl-Digest-MD5 )
	sha? ( virtual/perl-Digest-SHA )
	crc? ( dev-perl/Digest-CRC )
"

RDEPEND="${DEPEND}"
