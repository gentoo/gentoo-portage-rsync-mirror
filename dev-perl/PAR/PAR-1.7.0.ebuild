# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PAR/PAR-1.7.0.ebuild,v 1.1 2012/11/04 12:52:47 tove Exp $

EAPI=4

MODULE_AUTHOR=RSCHUPP
MODULE_VERSION=1.007
inherit perl-module

DESCRIPTION="Perl Archive Toolkit"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-solaris"
IUSE=""

DEPEND="
	virtual/perl-AutoLoader
	>=virtual/perl-IO-Compress-1.30
	>=dev-perl/Archive-Zip-1.00
	>=dev-perl/PAR-Dist-0.32
"
RDEPEND="${DEPEND}"

SRC_TEST=do
