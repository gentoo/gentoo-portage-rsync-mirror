# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CQL-Parser/CQL-Parser-1.120.0.ebuild,v 1.2 2014/08/04 17:36:30 zlogene Exp $

EAPI=4

MODULE_AUTHOR=BRICAS
MODULE_VERSION=1.12
inherit perl-module

DESCRIPTION="compiles CQL strings into parse trees of Node subtypes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Clone
	>=dev-perl/Class-Accessor-0.31
	>=dev-perl/String-Tokenizer-0.05
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.27
	)
"

SRC_TEST=do
