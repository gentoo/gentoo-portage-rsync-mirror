# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Visitor/Data-Visitor-0.280.0.ebuild,v 1.1 2012/02/13 14:57:26 tove Exp $

EAPI=4

MODULE_AUTHOR=DOY
MODULE_VERSION=0.28
inherit perl-module

DESCRIPTION="Visitor style traversal of Perl data structures"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/Class-Load-0.60.0
	>=dev-perl/Moose-0.890.0
	>=dev-perl/namespace-clean-0.190.0
	>=dev-perl/Tie-ToObject-0.01
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Requires
	)
"

SRC_TEST="do"
