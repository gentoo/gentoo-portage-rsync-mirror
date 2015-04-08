# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket-GetAddrInfo/Socket-GetAddrInfo-0.220.0.ebuild,v 1.1 2015/02/17 13:30:04 chainsaw Exp $

EAPI=5
MODULE_AUTHOR="PEVANS"
MODULE_VERSION="0.22"

inherit perl-module

DESCRIPTION="Address-family independent name resolving functions"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND=">=dev-perl/ExtUtils-CChecker-0.60.0
	virtual/perl-ExtUtils-CBuilder
	virtual/perl-Module-Build
	virtual/perl-Scalar-List-Utils
	virtual/perl-XSLoader
	test? ( virtual/perl-Test-Simple )
"
RDEPEND="virtual/perl-Exporter
	 virtual/perl-Socket"
PERL_RM_FILES=( t/99pod.t )
SRC_TEST="do"
