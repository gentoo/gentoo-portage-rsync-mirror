# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/RRD-Simple/RRD-Simple-1.440.0.ebuild,v 1.1 2011/08/29 09:45:34 tove Exp $

EAPI=4

MODULE_AUTHOR=NICOLAW
MODULE_VERSION=1.44
inherit perl-module

DESCRIPTION="Simple interface to create and store data in RRD files"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-perl/Test-Pod
	dev-perl/Test-Pod-Coverage
	virtual/perl-Module-Build"
RDEPEND="dev-perl/Test-Deep
	net-analyzer/rrdtool"
