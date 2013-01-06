# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-Class-DynamicDefault/DBIx-Class-DynamicDefault-0.40.0.ebuild,v 1.1 2012/04/15 06:03:18 tove Exp $

EAPI=4

MODULE_AUTHOR=MSTROUT
MODULE_VERSION=0.04
inherit perl-module

DESCRIPTION="Automatically set and update fields"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	>=dev-perl/DBIx-Class-0.81.270
"
DEPEND="
	test? ( ${RDEPEND}
		virtual/perl-parent
		dev-perl/DBICx-TestDatabase
	)"

SRC_TEST="do"
