# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-CompactTree-XS/XML-CompactTree-XS-0.20.0.ebuild,v 1.1 2011/08/28 06:59:01 tove Exp $

EAPI=4

MODULE_AUTHOR=PAJAS
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="a fast builder of compact tree structures from XML documents"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/XML-LibXML-1.69"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
