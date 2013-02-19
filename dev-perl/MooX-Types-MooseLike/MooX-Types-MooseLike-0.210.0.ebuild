# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooX-Types-MooseLike/MooX-Types-MooseLike-0.210.0.ebuild,v 1.1 2013/02/19 16:17:19 tove Exp $

EAPI=5

MODULE_AUTHOR=MATEU
MODULE_VERSION=0.21
inherit perl-module

DESCRIPTION="Some Moosish types and a type builder"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/Module-Runtime-0.12.0
	>=dev-perl/Moo-0.91.10
"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Set-Object
		>=dev-perl/Test-Fatal-0.3.0
		>=virtual/perl-Test-Simple-0.960.0
	)
"

SRC_TEST=do
