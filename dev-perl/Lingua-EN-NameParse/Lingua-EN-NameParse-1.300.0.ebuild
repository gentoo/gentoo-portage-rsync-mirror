# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-EN-NameParse/Lingua-EN-NameParse-1.300.0.ebuild,v 1.5 2012/02/03 14:29:13 ranger Exp $

EAPI=4

MODULE_AUTHOR=KIMRYAN
MODULE_VERSION=1.30
inherit perl-module

DESCRIPTION="Manipulate persons name"

SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="test"

RDEPEND="dev-perl/Parse-RecDescent"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST="do"
