# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Google-SafeBrowsing-Blocklist/Net-Google-SafeBrowsing-Blocklist-1.40.0.ebuild,v 1.2 2011/09/03 21:04:50 tove Exp $

EAPI=4

MODULE_AUTHOR=DANBORN
MODULE_VERSION=1.04
inherit perl-module

DESCRIPTION="Query a Google SafeBrowsing table"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="amd64 ppc x86"
IUSE="test"

RDEPEND="dev-perl/URI
	>=virtual/perl-Math-BigInt-1.87
	virtual/perl-DB_File
	|| (
		virtual/perl-Math-BigInt-FastCalc
		dev-perl/Math-BigInt-GMP
	)"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
