# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Format/Text-Format-0.580.0.ebuild,v 1.3 2013/01/13 11:30:39 ago Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=0.58

inherit perl-module

DESCRIPTION="Various subroutines to format text"

SLOT="0"
KEYWORDS="amd64 x86"

IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do parallel"
