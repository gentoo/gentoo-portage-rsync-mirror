# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Ima-DBI/Ima-DBI-0.350.0.ebuild,v 1.2 2011/09/03 21:05:07 tove Exp $

EAPI=4

MODULE_AUTHOR=PERRIN
MODULE_VERSION=0.35
inherit perl-module

DESCRIPTION="Add contextual fetches to DBI"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc ppc64 sparc x86 ~x86-solaris"
IUSE=""

RDEPEND="dev-perl/DBI
	dev-perl/Class-WhiteHole
	dev-perl/DBIx-ContextualFetch
	virtual/perl-Test-Simple
	>=dev-perl/Class-Data-Inheritable-0.02"
DEPEND="${RDEPEND}"

SRC_TEST="do"
