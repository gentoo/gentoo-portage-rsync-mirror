# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lexical-Persistence/Lexical-Persistence-1.20.0.ebuild,v 1.2 2013/01/13 13:55:23 maekke Exp $

EAPI=4

MODULE_AUTHOR=RCAPUTO
MODULE_VERSION=1.020
inherit perl-module

DESCRIPTION="Bind lexicals to persistent data."

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="test"

RDEPEND="dev-perl/PadWalker
	>=dev-perl/Devel-LexAlias-0.04"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
