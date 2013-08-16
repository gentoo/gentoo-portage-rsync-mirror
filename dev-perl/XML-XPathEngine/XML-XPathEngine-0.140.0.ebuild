# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-XPathEngine/XML-XPathEngine-0.140.0.ebuild,v 1.1 2013/08/16 07:56:08 patrick Exp $

EAPI=4

MODULE_AUTHOR=MIROD
MODULE_VERSION=0.14
inherit perl-module

DESCRIPTION="A re-usable XPath engine for DOM-like trees"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=""
DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST=do
