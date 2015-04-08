# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Command-Simple/Test-Command-Simple-0.040.0.ebuild,v 1.1 2013/04/02 08:18:01 pinkbyte Exp $

EAPI="5"

MODULE_AUTHOR="DMCBRIDE"
MODULE_VERSION=0.04

inherit perl-module

DESCRIPTION="Test external commands (nearly) as easily as loaded modules"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"
RDEPEND=""

SRC_TEST="do"
