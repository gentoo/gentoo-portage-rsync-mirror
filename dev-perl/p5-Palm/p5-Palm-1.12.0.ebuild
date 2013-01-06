# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/p5-Palm/p5-Palm-1.12.0.ebuild,v 1.6 2012/03/31 17:06:50 armin76 Exp $

EAPI=4

MODULE_AUTHOR=BDFOY
MODULE_VERSION=1.012
inherit perl-module

DESCRIPTION="Perl Module for Palm Pilots"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ppc x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
