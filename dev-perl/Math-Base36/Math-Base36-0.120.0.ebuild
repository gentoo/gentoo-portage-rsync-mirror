# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Math-Base36/Math-Base36-0.120.0.ebuild,v 1.2 2013/09/06 04:52:26 patrick Exp $

EAPI=4

MODULE_AUTHOR=BRICAS
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Encoding and decoding of base36 strings"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-aix"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception
	)
"

SRC_TEST="do"
