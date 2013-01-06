# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XPathEngine/XML-XPathEngine-0.130.0.ebuild,v 1.3 2012/01/28 15:19:43 phajdan.jr Exp $

EAPI=4

MODULE_AUTHOR=MIROD
MODULE_VERSION=0.13
inherit perl-module

DESCRIPTION="A re-usable XPath engine for DOM-like trees"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND=""
DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST=do
