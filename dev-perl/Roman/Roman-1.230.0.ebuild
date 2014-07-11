# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Roman/Roman-1.230.0.ebuild,v 1.7 2014/07/11 10:33:37 zlogene Exp $

EAPI=4

MODULE_AUTHOR=CHORNY
MODULE_VERSION=1.23
MODULE_A_EXT=zip

inherit perl-module

DESCRIPTION="Perl module for conversion between Roman and Arabic numerals"

SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~mips ~s390 x86 ~amd64-linux ~x86-linux"
IUSE="test"

DEPEND="test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do parallel"
