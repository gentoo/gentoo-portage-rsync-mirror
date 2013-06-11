# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/UNIVERSAL-can/UNIVERSAL-can-1.201.207.260.ebuild,v 1.7 2013/06/11 19:03:59 maekke Exp $

EAPI=4

MODULE_AUTHOR=CHROMATIC
MODULE_VERSION=1.20120726
inherit perl-module

DESCRIPTION="Hack around people calling UNIVERSAL::can() as a function"

SLOT="0"
KEYWORDS="amd64 ~arm ppc x86 ~ppc-aix"
IUSE="test"

RDEPEND="virtual/perl-Scalar-List-Utils"
DEPEND="
	test? (
		${RDEPEND}
		>=virtual/perl-Test-Simple-0.60
	)"

SRC_TEST="do"
