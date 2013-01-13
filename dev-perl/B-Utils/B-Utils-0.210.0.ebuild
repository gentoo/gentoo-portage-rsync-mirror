# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Utils/B-Utils-0.210.0.ebuild,v 1.2 2013/01/13 13:42:42 maekke Exp $

EAPI=4

MODULE_AUTHOR=JJORE
MODULE_VERSION=0.21
inherit perl-module

DESCRIPTION="Helper functions for op tree manipulation"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

DEPEND="
	>=dev-perl/extutils-depends-0.301
	test? (
		dev-perl/Test-Exception
	)
"

SRC_TEST=do
