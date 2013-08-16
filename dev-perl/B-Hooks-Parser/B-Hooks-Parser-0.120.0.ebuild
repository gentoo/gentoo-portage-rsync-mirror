# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/B-Hooks-Parser/B-Hooks-Parser-0.120.0.ebuild,v 1.1 2013/08/16 07:52:46 patrick Exp $

EAPI=4

MODULE_AUTHOR=ETHER
MODULE_VERSION=0.12
inherit perl-module

DESCRIPTION="Interface to perls parser variables"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/B-Hooks-OP-Check"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.302
	test? ( dev-perl/Test-Exception
		dev-perl/B-Hooks-EndOfScope )"
SRC_TEST=do
