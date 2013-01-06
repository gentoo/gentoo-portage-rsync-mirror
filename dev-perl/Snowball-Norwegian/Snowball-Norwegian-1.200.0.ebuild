# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Snowball-Norwegian/Snowball-Norwegian-1.200.0.ebuild,v 1.2 2011/09/03 21:05:29 tove Exp $

EAPI=4

MODULE_AUTHOR=ASKSH
MODULE_VERSION=1.2
inherit perl-module

DESCRIPTION="Porters stemming algorithm for Norwegian"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST="do"
