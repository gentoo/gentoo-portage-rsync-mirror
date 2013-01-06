# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/indirect/indirect-0.260.0.ebuild,v 1.2 2012/12/22 18:26:33 ago Exp $

EAPI=4

MODULE_AUTHOR=VPIT
MODULE_VERSION=0.26
inherit perl-module

DESCRIPTION="Lexically warn about using the indirect object syntax"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)"

SRC_TEST=do
