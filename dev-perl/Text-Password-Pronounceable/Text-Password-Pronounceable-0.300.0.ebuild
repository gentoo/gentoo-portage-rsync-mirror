# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Password-Pronounceable/Text-Password-Pronounceable-0.300.0.ebuild,v 1.1 2012/02/03 20:12:38 tove Exp $

EAPI=4

MODULE_VERSION=0.30
MODULE_AUTHOR=TSIBLEY
inherit perl-module

DESCRIPTION="Generate pronounceable passwords"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"

SRC_TEST="do"
