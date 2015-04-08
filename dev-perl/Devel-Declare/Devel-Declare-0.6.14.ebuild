# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Declare/Devel-Declare-0.6.14.ebuild,v 1.1 2013/09/06 19:51:45 zlogene Exp $

EAPI=5

MODULE_AUTHOR=ETHER
MODULE_VERSION=0.006014
inherit perl-module

DESCRIPTION="Adding keywords to perl, in perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Sub-Name
	virtual/perl-Scalar-List-Utils
	>=dev-perl/B-Hooks-OP-Check-0.190.0
	dev-perl/B-Hooks-EndOfScope
"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.302
	test? (
		>=virtual/perl-Test-Simple-0.88
	)
"

SRC_TEST=do
