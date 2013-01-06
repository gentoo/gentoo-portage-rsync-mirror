# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Roman/Roman-1.230.0.ebuild,v 1.2 2013/01/03 18:01:11 pinkbyte Exp $

EAPI=4

MODULE_AUTHOR=CHORNY
MODULE_VERSION=1.23
MODULE_A_EXT=zip

inherit perl-module

DESCRIPTION="Perl module for conversion between Roman and Arabic numerals"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="test"

DEPEND="test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do parallel"
