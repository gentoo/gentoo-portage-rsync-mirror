# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.620.0.ebuild,v 1.6 2013/02/20 15:58:08 ago Exp $

EAPI=4

MODULE_AUTHOR=AMBS
MODULE_SECTION=XML
MODULE_VERSION=0.62
inherit perl-module

DESCRIPTION="A perl XML down translate module"

SLOT="0"
KEYWORDS="alpha amd64 hppa ppc x86"
IUSE="test"

RDEPEND="
	dev-perl/libwww-perl
	>=dev-perl/XML-LibXML-1.600.0
	>=dev-perl/XML-DTDParser-2.0.0
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
